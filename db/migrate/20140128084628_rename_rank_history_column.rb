class RenameRankHistoryColumn < ActiveRecord::Migration
  def change
    rename_column :ranking_histories, :type, :rank_type
  end
end
