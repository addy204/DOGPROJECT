class CreateBreedDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :breed_details do |t|
      t.string :temperament
      t.string :life_span
      t.string :weight
      t.string :height
      t.string :image_url
      t.references :breed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
