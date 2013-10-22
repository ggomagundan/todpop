class AddAppPackageToAppInfo < ActiveRecord::Migration
  def change
    add_column :app_infos, :android_package_name, :string
    add_column :app_infos, :ios_package_name, :string
  end
end
