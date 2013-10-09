class CreateAppInfos < ActiveRecord::Migration
  def self.up
    create_table :app_infos do |t|
      t.string :time
      t.string :one_star
      t.string :two_star
      t.string :max_money
      t.string :android_version
      t.string :ios_version
      t.string :app_server
      t.integer :popup_style
      t.string :popup_image
      t.text :popup_text
      t.timestamps
    end
  end

  def self.down
    drop_table :app_infos
  end
end
