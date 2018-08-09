class Company < ApplicationRecord
  has_many :jobs
  has_one :picture, as: :imageable
  validates :email, uniqueness: true
end