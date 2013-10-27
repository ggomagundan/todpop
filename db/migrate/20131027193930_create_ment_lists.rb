class CreateMentLists < ActiveRecord::Migration
  def change
    create_table :ment_lists do |t|
      t.string :kind
      t.text :content

      t.timestamps
    end
  end
end
