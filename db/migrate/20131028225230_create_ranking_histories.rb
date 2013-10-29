class CreateRankingHistories < ActiveRecord::Migration
  def change
    create_table :ranking_histories do |t|
      t.string :type
      t.date :start
      t.date :end
      t.string :rank_id
      t.integer :rank_point

      t.timestamps
    end
  end
end
