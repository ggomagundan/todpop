class RenameLateConnectionToLastConnectionToUser < ActiveRecord::Migration
  def change
  	rename_column :users, :late_connection, :last_connection
  end
end
