class AddIsAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :integer, :default => 0
  end
end
