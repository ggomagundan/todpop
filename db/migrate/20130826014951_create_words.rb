# -*- encoding : utf-8 -*-
class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name, :null => false
      t.string :mean, :null => false
      t.text :example_en
      t.text :example_ko
      t.string :phonetics
      t.integer :picture, :default => 0

      t.timestamps
    end
  end
end
