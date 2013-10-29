class RestoreColumnRankingPoint < ActiveRecord::Migration
  def change
    change_column :ranking_points, :week_start, :Date, :default => Date.today.beginning_of_week
    change_column :ranking_points, :week_end, :Date, :default => Date.today.end_of_week
    change_column :ranking_points, :mon_start, :Date, :default => Date.today.beginning_of_month
    change_column :ranking_points, :mon_end, :Date, :default => Date.today.end_of_month
  end
end
