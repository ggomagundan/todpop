class AddColumnStoreOpenAppInfo < ActiveRecord::Migration
  def change
    add_column :app_infos, :store_open, :integer, :default => 0
  end
end
