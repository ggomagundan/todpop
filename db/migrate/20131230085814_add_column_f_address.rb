class AddColumnFAddress < ActiveRecord::Migration
  def change
    add_column :users, :f_address, :string, :after => :address
  end
end
