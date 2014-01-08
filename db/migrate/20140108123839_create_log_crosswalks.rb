class CreateLogCrosswalks < ActiveRecord::Migration
  def change
    create_table :log_crosswalks do |t|
      t.integer :uid
      t.integer :campaign_idx
      t.string :campaign_title

      t.timestamps
    end
  end
end
