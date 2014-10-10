class AddCheckedNumToCart < ActiveRecord::Migration
  def self.up
    add_column :carts, :checked_num, :integer
  end
  def self.down
    remove_column :carts, :checked_num
  end
  
end
