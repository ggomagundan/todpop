class AddColumnCharacterToUser < ActiveRecord::Migration
  def change
    add_column :users, :character, :string, :default => "8", :after => :interest
  end
end
