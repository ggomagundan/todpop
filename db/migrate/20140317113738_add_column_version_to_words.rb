class AddColumnVersionToWords < ActiveRecord::Migration
  def change
    add_column :words, :voice, :integer
  end
end
