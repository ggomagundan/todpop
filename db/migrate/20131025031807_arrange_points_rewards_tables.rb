class ArrangePointsRewardsTables < ActiveRecord::Migration
  def change
    change_column :points, :user_id, :integer, :after => :id
    change_column :points, :point_type, :integer, :after => :user_id
    change_column :rewards, :reward_type, :integer, :after => :user_id

  end
end
