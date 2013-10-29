class AddColumnRankToRankingHistory < ActiveRecord::Migration
  def change
    add_column :ranking_histories, :rank, :integer, :after => :end
  end
end
