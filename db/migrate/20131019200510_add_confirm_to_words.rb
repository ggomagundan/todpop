class AddConfirmToWords < ActiveRecord::Migration
  def change
    add_column :words, :confirm, :integer, default: 0
  end
end
