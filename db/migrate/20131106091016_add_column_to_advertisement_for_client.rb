class AddColumnToAdvertisementForClient < ActiveRecord::Migration
  def change
    add_column :cpd_advertisements, :unit_price, :integer, :default => 0, :after => :remain
    add_column :cpd_advertisements, :pay_type, :integer, :default => 1, :after => :unit_price 
    
    add_column :cpdm_advertisements, :unit_price, :integer, :default => 0, :after => :remain
    add_column :cpdm_advertisements, :pay_type, :integer, :default => 1, :after => :unit_price 
    
    add_column :cpx_advertisements, :unit_price, :integer, :default => 0, :after => :remain
    add_column :cpx_advertisements, :pay_type, :integer, :default => 1, :after => :unit_price 
  end
end
