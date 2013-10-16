class AddAdNameToCpdmAdvertisement < ActiveRecord::Migration
  def change
    add_column :cpdm_advertisements, :ad_name, :string
  end
end
