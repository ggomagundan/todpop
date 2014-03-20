class AddColumnPinDtmToAppInfos < ActiveRecord::Migration
  def change
    add_column :app_infos, :pin_dtm, :integer
  end
end
