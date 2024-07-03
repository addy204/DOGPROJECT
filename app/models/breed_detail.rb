class BreedDetail < ApplicationRecord
  belongs_to :breed

  validates :temperament, :life_span, :weight, :height, :image_url, presence: true
  validates :breed_id, presence: true
end
