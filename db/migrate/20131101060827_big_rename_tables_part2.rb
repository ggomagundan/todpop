class BigRenameTablesPart2 < ActiveRecord::Migration
  def change
    rename_table :ranking_points, :ranking_currents
    rename_table :refund_infos, :refund_requests
    rename_table :rewards, :reward_logs
    rename_table :user_record_bests, :user_stage_bests
    rename_table :user_stages, :user_highest_levels

    change_column :user_stage_bests, :stage, :integer, :after => :level

    rename_column :users, :last_connection, :last_test
    rename_column :users, :attendance_time, :daily_test_count
    rename_column :inactive_users, :last_connection, :last_test
    rename_column :inactive_users, :attendance_time, :daily_test_count

  end
end
