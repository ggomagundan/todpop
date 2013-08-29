class AddImageToWords < ActiveRecord::Migration
  def change
    add_column :words, :image, :string
  end
end
