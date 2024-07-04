class AddDescriptionToSubBreeds < ActiveRecord::Migration[7.1]
  def change
    add_column :sub_breeds, :description, :text
  end
end
