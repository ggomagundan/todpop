# -*- encoding : utf-8 -*-
class CreateAppIntroduceVideos < ActiveRecord::Migration
  def change
    create_table :app_introduce_videos do |t|
      t.string :url

      t.timestamps
    end
  end
end
