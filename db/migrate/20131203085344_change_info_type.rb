class ChangeInfoType < ActiveRecord::Migration
  def change
    change_column :user_stage_infos, :stage_info, :text
  end
end
