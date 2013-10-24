class CreateUserTestHistories < ActiveRecord::Migration
  def change
    create_table :user_test_histories do |t|
      t.integer :user_id
      t.integer :category
      t.integer :level
      t.integer :stage
      t.integer :n_medals
      t.integer :score
      t.integer :reward
      t.integer :rank_point

      t.timestamps
    end
  end
end
