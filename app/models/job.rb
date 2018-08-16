class Job < ApplicationRecord

  has_many :job_tags
  has_many :tags, through: :job_tags
  belongs_to :company

  scope :most_recent, -> { order(created_at: :desc) }
  scope :list, -> { includes(:tags).all.most_recent.not_expired }
  scope :filtered_list, -> (filter) {
    wildcard = "%#{filter}%"
    job_name_matches = Job.where("jobs.name LIKE ?", wildcard).pluck(:id)
    tag_name_matches = Job.joins(:tags).where("tags.name LIKE ?", wildcard).pluck(:id)
    ids = job_name_matches + tag_name_matches
    Job.where(id: ids).most_recent.not_expired
  }
  scope :by_tag, -> (tag_id) { joins(:tags).where(tags: { id: tag_id }).most_recent }
  scope :not_expired, -> { where('created_at > ?', 30.days.ago)}

  def to_param
    "#{id}-#{name.gsub(" ", "-")}"
  end

end