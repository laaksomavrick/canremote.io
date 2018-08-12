
class CreateJob
  include ActiveModel::Validations
  attr_accessor :company_name,
                :company_email,
                :company_url,
                :company_photo,
                :job_name,
                :job_description,
                :job_url,
                :tags
  validates_presence_of :company_name,
                        :company_email,
                        :company_url,
                        :company_photo,
                        :job_name,
                        :job_description,
                        :job_url

  def initialize(params = {})
    @company_name = params[:company_name]
    @company_email = params[:company_email]
    @company_url = params[:company_url]
    @company_photo = params[:company_photo]
    @job_name = params[:job_name]
    @job_url = params[:job_url]
    @job_description = params[:job_description] || default_job_description
    @tags = params[:tags]
  end

  def do_it
    # Either create or retrieve the company
    company = Company.where(email: @company_email).first_or_create do |company|
      company.name = @company_name
      company.email = @company_email
      company.url = @company_url
    end
    # Create the company photo if it does not exist
    unless company.picture
<<<<<<< HEAD
      company.picture = Picture.create(
=======
      picture = company.picture = Picture.create(
>>>>>>> f96a946ce880139ee460943201b557e65c1a8fb1
        name: company.name,
        imageable_type: company.class.name,
        imageable_id: company.id,
      )
<<<<<<< HEAD
      company.picture.file.attach(@company_photo)
=======
      picture.file.attach(@company_photo)
>>>>>>> f96a946ce880139ee460943201b557e65c1a8fb1
    end
    # Either create or retrieve the tags
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
    # Create the Job with company_id
    job = Job.create(
      name: @job_name,
      description: @job_description,
      url: @job_url,
      company_id: company.id
    )
    # Associate the tags in JobTag
    tags.each do |tag|
      JobTag.create(
        tag_id: tag.id,
        job_id: job.id
      )
    end
    job
  end

  def default_job_description
    <<~EOF
    ## Summary
    Type a brief summary of your job here.

    ## Responsibilities
    * Type a list of responsibilities here
    * and here. 
    EOF
  end

end