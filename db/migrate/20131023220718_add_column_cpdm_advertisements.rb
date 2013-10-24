class AddColumnCpdmAdvertisements < ActiveRecord::Migration
  def change
  	add_column :cpdm_advertisements, :video, :string
  end
end
