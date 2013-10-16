class AddAdNameToCpdAdvertisement < ActiveRecord::Migration
  def change
    add_column :cpd_advertisements, :ad_name, :string
  end
end
