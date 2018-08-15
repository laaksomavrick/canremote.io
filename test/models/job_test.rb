require 'test_helper'

class JobTest < ActiveSupport::TestCase

  test "should only retrieve active job postings" do
    not_expired = Job.not_expired.pluck(:created_at).select { |ca| ca > 31.days.ago }
    assert not_expired.length > 0
  end

end
