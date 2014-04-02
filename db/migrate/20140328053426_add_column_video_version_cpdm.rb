class AddColumnVideoVersionCpdm < ActiveRecord::Migration
  def change
    add_column :cpdm_advertisements, :video_ver, :integer, :default => 0
  end
end
