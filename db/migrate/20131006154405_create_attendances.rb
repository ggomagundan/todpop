# -*- encoding : utf-8 -*-
class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user
      t.datetime :attendance_day

      t.timestamps
    end
  end
end
