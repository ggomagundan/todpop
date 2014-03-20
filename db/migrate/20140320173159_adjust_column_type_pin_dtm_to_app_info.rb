class AdjustColumnTypePinDtmToAppInfo < ActiveRecord::Migration
  def change
    change_column :app_infos, :pin_dtm, :string
  end
end
