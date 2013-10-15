class AddAdTypeToAdvertiseLog < ActiveRecord::Migration
  def change
    add_column :advertise_logs, :ad_type, :integer
  end
end
