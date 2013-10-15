class AddPriorityToCpdAdvertisement < ActiveRecord::Migration
  def change
    add_column :cpd_advertisements, :priority, :integer, :default => 4
  end
end
