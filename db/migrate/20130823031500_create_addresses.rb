class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :depth1
      t.string :depth2

      t.timestamps
    end
  end
end
