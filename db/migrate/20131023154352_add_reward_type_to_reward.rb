class AddRewardTypeToReward < ActiveRecord::Migration
  def change
    add_column :rewards, :reward_type, :integer
  end
end
