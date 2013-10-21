class RenameColumnCpdAdvertisement < ActiveRecord::Migration
  def change
  	rename_column :cpd_advertisements, :kind, :ad_type
  	rename_column :cpd_advertisements, :start_time, :start_date
  	rename_column :cpd_advertisements, :end_time, :end_date
  end
end
