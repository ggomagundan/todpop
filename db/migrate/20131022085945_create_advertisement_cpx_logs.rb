class CreateAdvertisementCpxLogs < ActiveRecord::Migration
  def change
    create_table :advertisement_cpx_logs do |t|
      t.integer :ad_id
      t.integer :ad_type
      t.integer :user_id
      t.integer :action

      t.timestamps
    end
  end
end
