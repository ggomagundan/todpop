class AddColumnDailyTestRewardToUser < ActiveRecord::Migration
  def change
    add_column :users, :daily_test_reward, :integer, :default => 0, :after => :daily_test_count
  end
end
