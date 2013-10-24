class AddContentToRewardSum < ActiveRecord::Migration
  def change
    add_column :reward_sums, :content, :string, :default => "THIS IS NOTICE"
  end
end
