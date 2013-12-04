class CreateUserStageInfos < ActiveRecord::Migration
  def change
    create_table :user_stage_infos do |t|
      t.integer :user_id
      t.string  :stage_info

      t.timestamps
    end
  end
end
