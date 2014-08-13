class AddSkipToCpdmAdvertisements < ActiveRecord::Migration
  def change
    add_column :cpdm_advertisements, :skip, :integer
  end
end
