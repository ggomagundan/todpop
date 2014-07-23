class AddColumnMajorVerToAppInfoPro < ActiveRecord::Migration
  def change
    add_column :app_info_pros, :major_version, :string, :after => :id
  end
end
