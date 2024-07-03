class Image < ApplicationRecord
  belongs_to :breed

  validates :url, presence: true, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" }
  validates :breed_id, presence: true
end
