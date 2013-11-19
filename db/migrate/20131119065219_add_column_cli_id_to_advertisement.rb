class AddColumnCliIdToAdvertisement < ActiveRecord::Migration
  def change
    add_column :cpd_advertisements, :cli_id, :integer, :after => :ad_name
    add_column :cpdm_advertisements, :cli_id, :integer, :after => :ad_name
    add_column :cpx_advertisements, :cli_id, :integer, :after => :ad_name
  end
end
