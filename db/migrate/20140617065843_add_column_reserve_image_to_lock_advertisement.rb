class AddColumnReserveImageToLockAdvertisement < ActiveRecord::Migration
  def change
    add_column :lock_advertisements, :reserve_image, :string, :after => :ad_image
  end
end
