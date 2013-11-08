class RemoveDefaultValFromRankingCurrent < ActiveRecord::Migration
  def change
    change_column :ranking_currents, :week_start, :date
    change_column :ranking_currents, :week_end,   :date
    change_column :ranking_currents, :mon_start,  :date
    change_column :ranking_currents, :mon_end,    :date
  end
end
