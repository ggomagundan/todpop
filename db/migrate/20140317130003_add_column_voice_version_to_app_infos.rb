class AddColumnVoiceVersionToAppInfos < ActiveRecord::Migration
  def change
    add_column :app_infos, :voice_ver, :integer
  end
end
