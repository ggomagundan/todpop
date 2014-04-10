class CreateLogSignUps < ActiveRecord::Migration
  def change
    create_table :log_sign_ups do |t|
      t.text :invalue
      t.boolean :status
      t.string :msg
      t.text :elog

      t.timestamps
    end
  end
end
