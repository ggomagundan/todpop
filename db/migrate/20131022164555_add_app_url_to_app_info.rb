class AddAppUrlToAppInfo < ActiveRecord::Migration
  def change
    add_column :app_infos, :market_url, :string
    add_column :app_infos, :appstore_url, :string
  end
end
