class ChangeCpdmTable < ActiveRecord::Migration
  def change
    rename_column :cpdm_advertisements, :unit_price, :basic_show_price
    add_column :cpdm_advertisements, :full_show_price, :integer
    add_column :cpdm_advertisements, :additional_share_price, :integer
    add_column :cpdm_advertisements, :reward, :integer
    add_column :cpdm_advertisements, :point, :integer
    add_column :cpdm_advertisements, :name, :string
    add_column :cpdm_advertisements, :caption, :string
    add_column :cpdm_advertisements, :description, :string
    add_column :cpdm_advertisements, :link, :string
    add_column :cpdm_advertisements, :picture, :string
  end
end
