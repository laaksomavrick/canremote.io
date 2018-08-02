class Company < ApplicationRecord
  has_many :jobs
  validates :email, uniqueness: true
end