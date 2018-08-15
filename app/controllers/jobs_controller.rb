class JobsController < ApplicationController

  def index
    # TODO: comma separated list multiple query?
    search_query = params[:search_query]
    if search_query
      @jobs = Job.filtered_list(search_query)
    else
      @jobs = Job.list
    end
  end

  def category
    tag_name = params[:tag_name]
    @tag = Tag.where(name: tag_name).first
    @jobs = Job.by_tag(@tag.id)
  end

  def show
    @job = Job.includes(:tags).find(params[:id])
  end

  def new
    @job_form = JobForm.new
  end

  def create
    @job_form = JobForm.new(params)
    if @job_form.valid?
      job = @job_form.call
      redirect_to job
    else
      render 'new'
    end
  end

end