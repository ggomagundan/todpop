# -*- encoding : utf-8 -*-
class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :level, :null => false
      t.integer :stage, :null => false
      t.integer :index, :null => false
      t.integer :word_id, :null => false, :references => :words

      t.timestamps
    end
  end
end
