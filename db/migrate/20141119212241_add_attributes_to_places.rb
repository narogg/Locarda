class AddAttributesToPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :tel, :string
    add_column :places, :mob, :string
    add_column :places, :email, :string
    add_column :places, :address, :string
  end
  
  def self.down
    remove_column :places, :tel, :string
    remove_column :places, :mob, :string
    remove_column :places, :email, :string
    remove_column :places, :address, :string
  end
  
end
 
