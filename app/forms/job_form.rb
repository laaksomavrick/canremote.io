
class JobForm

  include ActiveModel::Validations

  attr_accessor :company_name,
                :company_email,
                :company_url,
                :company_photo,
                :job_name,
                :job_description,
                :job_url,
                :job_tag,
                :highlight,
                :tags

  validates_presence_of :company_name,
                        :company_email,
                        :company_url,
                        :company_photo,
                        :job_name,
                        :job_description,
                        :job_url,
                        :job_tag,
                        :highlight

  def initialize(params = {})
    @company_name = params[:company_name]
    @company_email = params[:company_email]
    @company_url = params[:company_url]
    @company_photo = params[:company_photo]
    @job_name = params[:job_name]
    @job_url = params[:job_url]
    @job_description = params[:job_description] || default_job_description
    @job_tag = params[:job_tag]
    @highlight = set_highlight(params[:highlight])
    @tags = params[:tags]
  end

  def call
    company = handle_company
    tags = handle_tags
    job = handle_job
    handle_job_tags(job, tags)
    job
  end

  private

  def handle_company
    company = Company.where(email: @company_email).first_or_create do |company|
      company.name = @company_name
      company.email = @company_email
      company.url = @company_url
    end
    unless company.picture
      company.picture = Picture.create(
        name: company.name,
        imageable_type: company.class.name,
        imageable_id: company.id,
      )
      company.picture.file.attach(@company_photo)
    end
    company
  end

  def handle_tags
    tags = []
    if @tags
      # TODO: tag whitelist?
      names = @tags.split(/\s*,\s*/)
      names.each do |name|
        tags << Tag.where(name: name).first_or_create do |tag|
          tag.name = name
        end
      end
    end
    tags
  end

  def handle_job
    Job.create(
      name: @job_name,
      description: @job_description,
      url: @job_url,
      company_id: company.id,
      highlight: @highlight
    )
  end

  def handle_job_tags(job, tags)
    required_tag_id = Tag.where(name: @job_tag, original: true).first.id
    JobTag.create(
      tag_id: required_tag_id,
      job_id: job.id
    )
    tags.each do |tag|
      JobTag.create(
        tag_id: tag.id,
        job_id: job.id
      )
    end
  end 

  def set_highlight(value)
    value == 'highlight'
  end

  def default_job_description
    <<~EOF
    ## Summary
    Type a brief summary of your job here.

    ## Responsibilities
    * Use the asterisks
    * to create a bulleted list

    ## Contact
    If preferred, add an email address or instructions to apply here.
    EOF
  end

end