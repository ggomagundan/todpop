class ChangeColumnDefaultValue < ActiveRecord::Migration
  def change
    change_column :orders, :is_expired, :boolean, :default => false
  end
end
