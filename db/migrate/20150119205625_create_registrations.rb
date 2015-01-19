class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :user_id
      t.string :gcm_reg_id

      t.timestamps
    end
  end
end
