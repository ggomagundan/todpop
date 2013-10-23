class ChangeActionToAct < ActiveRecord::Migration
  def change
  	rename_column :advertise_cpd_logs, :action, :act
  	rename_column :advertisement_cpx_logs, :action, :act
  end
end
