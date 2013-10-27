class SetDefaultRewardToUsers < ActiveRecord::Migration
  def change
    change_column :users, :current_reward, :integer, :default => 0
    change_column :users, :total_reward, :integer, :default => 0
  end
end
