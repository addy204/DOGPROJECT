class SubBreed < ApplicationRecord
  belongs_to :breed

  validates :name, presence: true
  validates :breed_id, presence: true
end
