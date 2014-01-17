class AdjustCpdColumn < ActiveRecord::Migration
  def change
    rename_column :cpd_advertisements, :unit_price, :basic_show_price
  end
end
