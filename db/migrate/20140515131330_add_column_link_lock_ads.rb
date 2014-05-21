class AddColumnLinkLockAds < ActiveRecord::Migration
  def change
    add_column :lock_advertisements, :linked_id, :integer, :after => :ad_name
    add_column :lock_advertisements, :link, :integer, :default => 0, :after => :ad_name
  end
end
