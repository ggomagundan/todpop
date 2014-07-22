class CreateAppInfoPros < ActiveRecord::Migration
  def change
    create_table :app_info_pros do |t|
      t.string :android_version
      t.string :android_package_name
      t.string :market_url

      t.timestamps
    end
  end
end
