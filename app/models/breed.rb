class Breed < ApplicationRecord
  has_many :sub_breeds, dependent: :destroy
  has_one :breed_detail, dependent: :destroy
end
