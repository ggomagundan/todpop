class AddColumnInExpiredToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :is_expired, :boolean
  end
end
