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
    tag_id = params[:tag_id]
    @tag = Tag.find(tag_id)
    @jobs = Job.by_tag(tag_id)
  end

  def show
    @job = Job.includes(:tags).find(params[:id])
  end

  def new
  end

  def create
    # TODO Virtus; new form obj
    create_job = CreateJob.new(params)
    if create_job.valid?
      job = create_job.do_it
      render json: job
    else
      render json: create_job.errors
    end
  end

end