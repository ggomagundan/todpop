class RenameColumnCountToContract < ActiveRecord::Migration
  def change
  	rename_column :cpx_advertisements, :store_url, :target_url
  	rename_column :cpd_advertisements, :count, :contract
  	rename_column :cpdm_advertisements, :count, :contract
  	rename_column :cpx_advertisements, :count, :contract
  end
end
