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
    current_reward = User.current_reward
    total_reward = User.total_reward
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
    Reward.create(:user_id => @token_user_id, :point_type => @token_point_type, :name => @token_name,
                    :point => @token_point)

    # add to RankingPoint (w_1 ~ w4 & mon + update)
    update_rank_point_table



    #user = User.find_by_id(@token_user_id)
    #current_reward = User.current_reward
    #total_reward = User.total_reward
    #user.update_attributes(:current_reward => current_reward + @token_reward)
    #user.update_attributes(:total_reward => total_reward + @token_reward)


  end











  def update_rank_point_table
    @status=true
    @msg=""

    @category=params[:category].to_i
    @point=params[:point].to_i

    @date=RankingPoint.last
    @history=RankingHistory.new

    if !@date.present?
      @msg="not exist ranking point list"
      @status=false
    elsif @date.week_start+7 == Date.today
      (1..4).each do |i|
        (1..20).each do |j|
          a=RankingHistory.new
          a.start=@date.week_start
          a.end=@date.week_end
          if i==1
            a.type="Elementary_Week"
            @w_list=RankingPoint.order("week_1 DESC").limit(20)
            a.rank_point=@w_list[j-1].week_1
          elsif i==2
            a.type="Secondary_Week"
            @w_list=RankingPoint.order("week_2 DESC").limit(20)
            a.rank_point=@w_list[j-1].week_2
          elsif i==3
            a.type="SAT_Week"
            @w_list=RankingPoint.order("week_3 DESC").limit(20)
            a.rank_point=@w_list[j-1].week_3
          elsif i==4
            a.type="TOEIC_Week"
            @w_list=RankingPoint.order("week_4 DESC").limit(20)
            a.rank_point=@w_list[j-1].week_4
          end
          a.rank=j
          a.rank_id=@w_list[j-1].id
          a.save
        end
      end

      @update_date=RankingPoint.all
      @update_date.update_all(:week_start => Date.today.beginning_of_week, :week_end => Date.today.end_of_week,
                             :week_1 => 0, :week_2 => 0, :week_3 => 0, :week_4 => 0)

      if @date.mon_end < Date.today
      (1..4).each do |i|
        (1..20).each do |j|
          a=RankingHistory.new
          a.start=@date.mon_start
          a.end=@date.mon_end
          if i==1
            a.type="Elementary_Month"
            @m_list=RankingPoint.order("mon_1 DESC").limit(20)
            a.rank_point=@m_list[j-1].mon_1
          elsif i==2
            a.type="Secondary_Month"
            @m_list=RankingPoint.order("mon_2 DESC").limit(20)
            a.rank_point=@m_list[j-1].mon_2
          elsif i==3
            a.type="SAT_Month"
            @m_list=RankingPoint.order("mon_3 DESC").limit(20)
            a.rank_point=@m_list[j-1].mon_3
          elsif i==4
            a.type="TOEIC_Month"
            @m_list=RankingPoint.order("mon_4 DESC").limit(20)
            a.rank_point=@mon_list[j-1].mon_4
          end
          a.rank=j
          a.rank_id=@m_list[j-1].id
          a.save
        end
      end
        @update_mon=RankingPoint.all
        @update_mon=update_all(:mon_start => Date.today.beginning_of_month, :mon_end => Date.today.end_of_month,
                              :mon_1 => 0, :mon_2 => 0, :mon_3 => 0, :mon_4 => 0)
      end
    elsif !@user=RankingPoint.find_by_id(params[:user_id])
      @status=false
      @msg="not exist user"
    else
      if @category==1
        @user.update_attributes(:week_1 => @user.week_1+@point, :mon_1 => @user.mon_1+@point)
      elsif @category==2
        @user.update_attributes(:week_2 => @user.week_2+@point, :mon_2 => @user.mon_2+@point)
      elsif @category==3
        @user.update_attributes(:week_3 => @user.week_3+@point, :mon_3 => @user.mon_3+@point)
      elsif @category==4
        @user.update_attributes(:week_4 => @user.week_4+@point, :mon_4 => @user.mon_4+@point)
      else
        @status=false
        @msg="ircorrect categoty or not exist point params"
      end
    end
  end






end
