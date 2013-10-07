class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.string :name
      t.integer :type
      t.integer :point
      t.integer :user_id

      t.timestamps
    end
  end
end
