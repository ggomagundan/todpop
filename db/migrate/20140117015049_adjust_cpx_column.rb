class AdjustCpxColumn < ActiveRecord::Migration
  def change
    rename_column :cpx_advertisements, :unit_price, :basic_show_price
  end
end
