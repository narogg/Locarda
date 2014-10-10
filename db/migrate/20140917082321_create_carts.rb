class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.integer :place_id
      t.integer :points

      t.timestamps
    end
  end
end
