class CreateRankingTempMonDs < ActiveRecord::Migration
  def change
    create_table :ranking_temp_mon_ds do |t|
      t.integer :user_id
      t.integer :score

      t.timestamps
    end
  end
end
