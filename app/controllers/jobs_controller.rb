class JobsController < ApplicationController

  def index
    query = params[:search_query]
    if query
      @jobs = Job.filtered_list(params[:search_query])
    else
      @jobs = Job.list
    end
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