class AdjustRankingPointColumn < ActiveRecord::Migration
  def change
    change_column :ranking_points, :week_start, :integer, :default => Date.today.beginning_of_week.day
    change_column :ranking_points, :week_end, :integer, :default => Date.today.end_of_week.day
    change_column :ranking_points, :mon_start, :integer, :default => Date.today.beginning_of_week.mon
    change_column :ranking_points, :mon_end, :integer, :default => Date.today.end_of_week.mon
  end
end
