class Owner < ApplicationRecord
  has_and_belongs_to_many :breeds

  validates :name, presence: true, uniqueness: true
end
