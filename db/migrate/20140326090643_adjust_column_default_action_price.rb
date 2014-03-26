class AdjustColumnDefaultActionPrice < ActiveRecord::Migration
  def change
    change_column :cpdm_advertisements, :full_show_price, :integer, :default => 0
    change_column :cpdm_advertisements, :additional_share_price, :integer, :default => 0
    
    change_column :cpd_advertisements, :action_price, :integer, :default => 0
  end
end
