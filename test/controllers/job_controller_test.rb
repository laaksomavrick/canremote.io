require 'test_helper'

class JobControllerTest < ActionDispatch::IntegrationTest

  def setup
    Rails.application.load_seed
  end

  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should have jobs in index" do
    get root_url
    assert_not_nil controller.instance_variable_get(:@jobs)
  end

  test "should get show" do
    id = Job.first.id
    get job_path(id)
    assert_response :success
  end

  test "should have job with details in show" do
    id = Job.first.id
    get job_path(id)
    assert_not_nil controller.instance_variable_get(:@job)
  end

end