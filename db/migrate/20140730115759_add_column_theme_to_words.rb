class AddColumnThemeToWords < ActiveRecord::Migration
  def change
    add_column :words, :themes, :integer, :after => :phonetics
  end
end
