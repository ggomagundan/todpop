class CreateRefundInfos < ActiveRecord::Migration
  def change
    create_table :refund_infos do |t|
      t.string :name
      t.string :bank
      t.string :account
      t.integer :sum
      t.string :comment

      t.timestamps
    end
  end
end
