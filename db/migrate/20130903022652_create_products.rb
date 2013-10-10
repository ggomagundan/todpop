# -*- encoding : utf-8 -*-
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :title
      t.string :content
      t.integer :rank
      t.string :image

      t.timestamps
    end
  end
end
