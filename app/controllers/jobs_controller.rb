class JobsController < ApplicationController

  def index
    @jobs = Job.includes(:tags).all.order(created_at: :desc)
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