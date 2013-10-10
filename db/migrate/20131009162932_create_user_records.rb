# -*- encoding : utf-8 -*-
class CreateUserRecords < ActiveRecord::Migration
  def change
    create_table :user_records do |t|
      t.integer :record_type
      t.integer :level
      t.integer :stage
      t.integer :record_point

      t.timestamps
    end
  end
end
