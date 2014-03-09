class AdjustRankTempIndex < ActiveRecord::Migration
  def change
    add_index :ranking_temp_week_as, :score
    add_index :ranking_temp_week_bs, :score
    add_index :ranking_temp_week_cs, :score
    add_index :ranking_temp_week_ds, :score
    
    add_index :ranking_temp_mon_as, :score
    add_index :ranking_temp_mon_bs, :score
    add_index :ranking_temp_mon_cs, :score
    add_index :ranking_temp_mon_ds, :score
  end
end
