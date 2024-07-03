class Breed < ApplicationRecord
  has_many :sub_breeds, dependent: :destroy
  has_one :breed_detail, dependent: :destroy
  has_many :images, dependent: :destroy
  has_and_belongs_to_many :owners

  validates :name, presence: true, uniqueness: true
end
