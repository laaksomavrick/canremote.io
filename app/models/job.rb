class Job < ApplicationRecord
  has_many :job_tags
  has_many :tags, through: :job_tags
  belongs_to :company

  scope :list, -> { includes(:tags).all.order(created_at: :desc) }
  scope :filtered_list, -> (filter) {
    wildcard = "%#{filter}%"
    job_name_matches = Job.list.where("name LIKE ?", wildcard)
    tag_name_matches = Job.joins(:tags).where("tags.name LIKE ?", wildcard)
    job_name_matches + tag_name_matches
  }
  scope :by_tag, -> (tag_id) { joins(:tags).where(tags: { id: tag_id }) }
end