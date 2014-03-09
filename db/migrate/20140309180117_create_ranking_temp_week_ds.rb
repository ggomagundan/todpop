class CreateRankingTempWeekDs < ActiveRecord::Migration
  def change
    create_table :ranking_temp_week_ds do |t|
      t.integer :user_id
      t.integer :score

      t.timestamps
    end
  end
end
