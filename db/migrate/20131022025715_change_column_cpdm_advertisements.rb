class ChangeColumnCpdmAdvertisements < ActiveRecord::Migration
  def change
  	add_column :cpdm_advertisements, :length, :integer
  	rename_column :cpdm_advertisements, :kind, :ad_type
  	rename_column :cpdm_advertisements, :start_time, :start_date
  	rename_column :cpdm_advertisements, :end_time, :end_date
  end
end
