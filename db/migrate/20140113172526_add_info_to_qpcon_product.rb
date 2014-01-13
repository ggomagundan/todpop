class AddInfoToQpconProduct < ActiveRecord::Migration
  def change
    add_column :qpcon_products, :info, :string
  end
end
