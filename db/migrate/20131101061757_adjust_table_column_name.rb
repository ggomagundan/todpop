class AdjustTableColumnName < ActiveRecord::Migration
  def change
    #app_infos
    rename_column :app_infos, :time, :time_quick_ans
    rename_column :app_infos, :one_star, :one_medal 
    rename_column :app_infos, :two_star, :two_medal
    rename_column :app_infos, :max_money, :test_reward_max
    rename_column :app_infos, :day_limit, :new_stage_day_limit
    
    rename_table :helps, :board_helps
    rename_table :levels, :word_levels
    rename_table :notices, :board_notices
    rename_table :points, :point_logs

    #ranking_histories
    rename_column :ranking_histories, :rank_id, :user_id
    rename_column :ranking_histories, :rank_point, :point
  end
end
