class CreateJoinTableBreedsOwners < ActiveRecord::Migration[7.1]
  def change
    create_join_table :breeds, :owners do |t|
      # t.index [:breed_id, :owner_id]
      # t.index [:owner_id, :breed_id]
    end
  end
end
