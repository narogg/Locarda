class AddAdminIdToPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :admin_id, :integer
  end
  
  def self.down
    remove_column :places, :admin_id
  end
end
