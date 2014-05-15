class AddColumnGroupLockLogs < ActiveRecord::Migration
  def change
    add_column :advertise_lock_logs, :group, :integer, :after => :ad_id
  end
end
