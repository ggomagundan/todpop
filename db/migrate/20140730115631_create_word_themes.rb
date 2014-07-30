class CreateWordThemes < ActiveRecord::Migration
  def change
    create_table :word_themes do |t|
      t.string :category
      t.string :title
      t.string :subject

      t.timestamps
    end
  end
end
