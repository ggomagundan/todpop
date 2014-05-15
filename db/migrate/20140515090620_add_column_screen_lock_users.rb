class AddColumnScreenLockUsers < ActiveRecord::Migration
  def change
    add_column :users, :screen_lock, :boolean, :after => :last_test
  end
end
