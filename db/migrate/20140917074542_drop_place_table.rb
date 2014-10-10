class DropPlaceTable < ActiveRecord::Migration
  
  def change
    create_table :places do |t|
      t.string :name
      t.string :full_name
      t.string :description
      t.string :rewards
      t.string :image_url

      t.timestamps
    end
  end
 
end
