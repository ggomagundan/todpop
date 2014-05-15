class AddColumnGroupScreenLock < ActiveRecord::Migration
  def change
    add_column :lock_advertisements, :group, :integer, :after => :cli_id
  end
end
