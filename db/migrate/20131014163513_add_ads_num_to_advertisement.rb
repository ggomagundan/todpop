class AddAdsNumToAdvertisement < ActiveRecord::Migration
  def change
    add_column :advertisements, :ads_num, :integer
  end
end
