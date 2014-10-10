class AddFullNameAdrressToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :full_name, :string
  end
end
