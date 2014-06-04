class AddColumnsToInactiveUsers < ActiveRecord::Migration
  def change
    add_column :inactive_users, :screen_lock, :boolean
    add_column :inactive_users, :region, :string
    add_column :inactive_users, :device, :string
    add_column :inactive_users, :android_ver, :string
    add_column :inactive_users, :operator, :string
    add_column :inactive_users, :device_id, :string
  end
end
