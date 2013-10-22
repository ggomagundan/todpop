class AddIsSetFacebookPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_set_facebook_password, :integer, :default => 0
  end
end
