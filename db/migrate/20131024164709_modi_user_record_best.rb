class ModiUserRecordBest < ActiveRecord::Migration
  def change
    rename_table :user_records, :user_record_bests
    rename_column :user_record_bests, :record_type, :n_medals_best
    rename_column :user_record_bests, :record_point, :score_best
    change_column :user_record_bests, :user_id, :integer, :after => :id
    change_column :user_record_bests, :n_medals_best, :integer, :after => :stage
    change_column :user_record_bests, :score_best, :integer, :after => :n_medals_best
  end
end
