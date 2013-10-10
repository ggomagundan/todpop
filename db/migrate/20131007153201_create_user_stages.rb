# -*- encoding : utf-8 -*-
class CreateUserStages < ActiveRecord::Migration
  def change
    create_table :user_stages do |t|
      t.integer :user_id
      t.integer :category 
      t.integer :stage
      t.integer :level

      t.timestamps
    end
  end
end
