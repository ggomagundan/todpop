class RenameOrdersTable < ActiveRecord::Migration
  def change
    rename_column :orders, :apporoval_number, :approval_number
  end
end
