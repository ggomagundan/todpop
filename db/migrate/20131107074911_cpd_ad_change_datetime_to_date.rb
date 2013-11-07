class CpdAdChangeDatetimeToDate < ActiveRecord::Migration
  def change
    change_column :cpd_advertisements, :start_date, :date
    change_column :cpd_advertisements, :end_date, :date
  end
end
