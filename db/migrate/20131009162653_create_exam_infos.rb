# -*- encoding : utf-8 -*-
class CreateExamInfos < ActiveRecord::Migration
  def change
    create_table :exam_infos do |t|
      t.integer :time
      t.integer :one_star
      t.integer :two_star
      t.integer :max_money

      t.timestamps
    end
  end
end
