class ModiRewardsRefundinfoTables < ActiveRecord::Migration
  def change
    rename_column :refund_infos, :sum, :amount
    change_column :refund_infos, :user_id, :integer, :after => :id
    rename_column :rewards, :reward_point, :reward
  end
end
