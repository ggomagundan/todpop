class CreateRankingPoints < ActiveRecord::Migration
  def change
    create_table :ranking_points do |t|
      t.integer :week_1
      t.integer :week_2
      t.integer :week_3
      t.integer :week_4
      t.datetime :week_start
      t.datetime :week_end
      t.integer :mon_1
      t.integer :mon_2
      t.integer :mon_3
      t.integer :mon_4
      t.datetime :mon_start
      t.datetime :mon_end

      t.timestamps
    end
  end
end
