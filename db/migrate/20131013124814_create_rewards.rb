class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.integer :user_id
      t.string :title
      t.string :sub_title
      t.integer :reward_point

      t.timestamps
    end
  end
end
