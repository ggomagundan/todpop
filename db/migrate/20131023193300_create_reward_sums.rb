class CreateRewardSums < ActiveRecord::Migration
  def change
    create_table :reward_sums do |t|
      t.integer :current, default=0
      t.integer :total, default=0

      t.timestamps
    end
  end
end
