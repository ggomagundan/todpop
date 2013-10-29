class AdjustRankingPoint < ActiveRecord::Migration
  def change
    change_column :ranking_points, :week_1, :integer, :default => 0
    change_column :ranking_points, :week_2, :integer, :default => 0
    change_column :ranking_points, :week_3, :integer, :default => 0
    change_column :ranking_points, :week_4, :integer, :default => 0
    
    change_column :ranking_points, :mon_1, :integer, :default => 0
    change_column :ranking_points, :mon_2, :integer, :default => 0
    change_column :ranking_points, :mon_3, :integer, :default => 0
    change_column :ranking_points, :mon_4, :integer, :default => 0
  end
end
