class AddColumnAppIntroduceVideo < ActiveRecord::Migration
  def change
  	add_column :app_introduce_videos, :video, :string
  end
end
