class ChangeDateStartForPrizes < ActiveRecord::Migration
  def change
    change_table :prizes do |t|  
      t.change :date_start, :date
      t.change :date_end, :date
    end
  end
end
