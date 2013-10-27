class AdjustToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_reward, :integer
    add_column :users, :total_reward, :integer
    remove_column :users, :point, :integer
    remove_column :users, :date, :datetime
    change_column :users, :interest, :integer, :after => :mobile
    change_column :users, :level_test, :integer, :after => :interest
    change_column :users, :is_set_facebook_password, :integer, :after => :level_test
    change_column :users, :attendance_time, :integer, :after => :is_set_facebook_password
    change_column :users, :current_reward, :integer, :after => :attendance_time
    change_column :users, :total_reward, :integer, :after => :current_reward
    change_column :users, :is_admin, :integer, :after => :total_reward
  end
end
