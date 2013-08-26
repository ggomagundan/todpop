class AddWordLevelToWords < ActiveRecord::Migration
  def change
    add_column :words, :level, :integer 
    add_column :words, :stage, :integer
    add_column :words, :word_index, :integer
  end
end
