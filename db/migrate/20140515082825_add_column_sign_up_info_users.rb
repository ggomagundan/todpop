class AddColumnSignUpInfoUsers < ActiveRecord::Migration
  def change
    add_column :users, :region, :string
    add_column :users, :device, :string
    add_column :users, :android_ver, :string
    add_column :users, :operator, :string
  end
end
