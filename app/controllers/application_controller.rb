# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception






  #                      reward_type      point_type(rank_point)
  #      --------------------------------------------------
  #      Test       =   1000+category      1000+category
  #      Attendace  =     2000                2000
  #      Recommend  =     3000                3000
  #        CPX      =   4000+CPX_code      4000+CPX_code
  #       Refund    =     7000
  #



  def process_reward_general

    ########################################################
    #
    # [ Reward process ]
    #  - general : @token_user_id @token_reward_type @token_title @token_sub_title @token_reward
    #  - refund  : @token_bank @token_account @token_commenttle
    #
    # log : Reward
    # add : User.current_reward & User.total_reward
    #
    # refund case : RefundInfo
    #
    #######################################################

    # log to Reward (all history)
    Reward.create(:user_id => @token_user_id, :reward_type => @token_reward_type, :title => @token_title,
                    :sub_title => @token_sub_title, :reward => @token_reward)

    # add to User (current_reward, total_reward)
    user = User.find_by_id(@token_user_id)
    current_reward = user.current_reward
    total_reward = user.total_reward
    user.update_attributes(:current_reward => current_reward + @token_reward)
    user.update_attributes(:total_reward => total_reward + @token_reward)

    # refund to RefundInfo (all refund history)
    if @token_reward_type == 7000
      RefundInfo.create(:user_id => @token_user_id, :name => @token_name, :bank => @token_bank,
                          :account => @token_account, :amount => @toekn_reward, :comment => @token_comment)
    end

  end




  def process_point_general

    ########################################################
    #
    # [ Rank point process ]
    #  - general : @token_user_id @token_point_type @token_name @token_point
    #
    # log : Point
    # add : RankingPoint with weekly/monthly update
    #
    #######################################################

    # log to Point (all history)
    Point.create(:user_id => @token_user_id, :point_type => @token_point_type, :name => @token_name,
                    :point => @token_point)

    # add to RankingPoint (w_1 ~ w4 & mon + update)
    update_rank_point_table

    if (@token_point_type > 1000) && (@token_point_type < 2000)           # from test
      category_start = @token_point_type - 1000
      category_end   = @token_point_type - 1000
    else
      category_start = 1
      category_end   = 4
    end

    user = RankingPoint.find_by_id(@token_user_id)
    (category_start..category_end).each do |i|
      tmp = "user.update_attributes(:week_" + i.to_s + " => user.week_" + i.to_s + " + @token_point, :mon_" + i.to_s + " => user.mon_" + i.to_s + " + @token_point)"
      eval(tmp)
    end

  end



  def update_rank_point_table

    ranking_point = RankingPoint.find_by_id(@token_user_id)

    if !ranking_point.present?
      @status=false
      @msg="not exist ranking point table for the user"
    end

    if (@status == true) && (ranking_point.week_end < Date.today)            # need to update week

      (1..4).each do |i|
        tmp = "w_list = RankingPoint.order(\"week_" + i.to_s + " DESC\").limit(20)"
        eval(tmp)
        tmp = "type = \"week_" + i.to_s + "\""
        eval(tmp)
        week_start = ranking_point.week_start
        week_end   = ranking_point.week_end

        (1..w_list.size).each do |j|
          a = RankingHistory.new
          a.start = week_start
          a.end   = week_end
          a.rank  = j
          a.rank_id = w_list[j-1].id
          tmp = "a.rank_point = w_list[j-1].week_" + i.to_s
          eval(tmp)
          a.save
        end
      end

      update_rp_week = RankingPoint.all
      update_rp_week.update_all(:week_start => Date.today.beginning_of_week, :week_end => Date.today.end_of_week,
                                  :week_1 => 0, :week_2 => 0, :week_3 => 0, :week_4 => 0)
    end


    if (@status == true) && (ranking_point.mon_end < Date.today)             # need to update month

      (1..4).each do |i|
        tmp = "m_list = RankingPoint.order(\"mon_" + i.to_s + " DESC\").limit(20)"
        eval(tmp)
        tmp = "type = \"month_" + i.to_s + "\""
        eval(tmp)
        mon_start = ranking_point.mon_start
        mon_end   = ranking_point.mon_end

        (1..m_list.size).each do |j|
          a = RankingHistory.new
          a.start = mon_start
          a.end   = mon_end
          a.rank  = j
          a.rank_id = m_list[j-1].id
          tmp = "a.rank_point = m_list[j-1].mon_" + i.to_s
          eval(tmp)
          a.save
        end
      end

      update_rp_month = RankingPoint.all
      update_rp_month.update_all(:mon_start => Date.today.beginning_of_month, :mon_end => Date.today.end_of_month,
                                   :mon_1 => 0, :mon_2 => 0, :mon_3 => 0, :mon_4 => 0)
    end

  end






end
