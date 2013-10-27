class CreateBankLists < ActiveRecord::Migration
  def change
    create_table :bank_lists do |t|
      t.string :name

      t.timestamps
    end
  end
end
