class ChangeTableNameFromProductsToPrizes < ActiveRecord::Migration
  def change
    rename_table :products, :prizes
  end
end
