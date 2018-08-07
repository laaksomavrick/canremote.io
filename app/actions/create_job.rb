
class CreateJob
  include ActiveModel::Validations
  attr_accessor :company_name, :company_email, :job_name, :job_description, :tags
  validates_presence_of :company_name, :company_email, :job_name, :job_description

  def initialize(params = {})
    @company_name = params[:company_name]
    @company_email = params[:company_email]
    @job_name = params[:job_name]
    @job_description = params[:job_description] || default_job_description
    @tags = params[:tags]
  end

  def do_it
    # Either create or retrieve the company
    company = Company.where(email: @company_email).first_or_create do |company|
      company.name = @company_name
      company.email = @company_email
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
    """## Summary
Type a brief summary of your job here.

## Responsibilities
* Type a list of responsibilities here
* and here. 
    """
  end

end