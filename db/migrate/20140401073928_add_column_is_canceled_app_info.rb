class AddColumnIsCanceledAppInfo < ActiveRecord::Migration
  def change
    add_column :orders, :is_canceled, :boolean, :default => 0
  end
end
