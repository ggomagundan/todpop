class ChangeDefaultValue < ActiveRecord::Migration
  def change
  	change_column :cpd_advertisements, :ad_type, :integer, :default => nil
  	change_column :cpdm_advertisements, :ad_type, :integer, :default => 201
  end
end
