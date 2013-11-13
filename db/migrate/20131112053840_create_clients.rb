class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :cor_name
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :mobile

      t.timestamps
    end
  end
end
