class ArrangeTable < ActiveRecord::Migration
  def change
  	drop_table :advertisements
  	drop_table :cpd_ads
  	drop_table :advertise_logs
  	rename_table :advertisement_cpx_logs, :advertise_cpx_logs
  end
end
