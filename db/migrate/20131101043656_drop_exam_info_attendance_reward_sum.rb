class DropExamInfoAttendanceRewardSum < ActiveRecord::Migration
  def change
    drop_table :exam_infos
    drop_table :attendances
    drop_table :reward_sums
  end
end
