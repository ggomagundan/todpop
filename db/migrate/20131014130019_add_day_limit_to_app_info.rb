class AddDayLimitToAppInfo < ActiveRecord::Migration
  def change
    add_column :app_infos, :day_limit, :integer
  end
end
