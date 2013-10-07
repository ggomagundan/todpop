class AddAttendaceToUser < ActiveRecord::Migration
  def change
    add_column :users, :attendance_time, :integer, :default => 0
  end
end
