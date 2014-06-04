class CreateWeeklyChallengeLogs < ActiveRecord::Migration
  def change
    create_table :weekly_challenge_logs do |t|
      t.integer :user_id
      t.string :combo
      t.integer :result
      t.integer :score

      t.timestamps
    end
  end
end
