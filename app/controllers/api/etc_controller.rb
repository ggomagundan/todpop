class Api::EtcController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def refund_info
    @status = true
    @msg = ""

    @user = User.find_by_id(params[:id])
    @ment = MentList.find_by_kind("refund")

    if !@user.present?
      @status = false
      @msg = "Not exist user"
    elsif !@ment.present?
      @status = false
      @msg = "Not exist refund ment"
    end

    if @status == true
      @current_reward = @user.current_reward
      @content = @ment.content
    end

  end

  def get_bank_list
    @status = true
    @msg = ""

    @bank_list = BankList.all.pluck(:name).uniq
 
  end



  def refund
    @status = true
    @msg = "requested"

    if !params[:user_id].present? || !params[:name].present? || !params[:bank].present? || !params[:account].present? || !params[:amount].present? || !params[:password].present?
      @status=false
      @msg = "not exist some of params"
    else
      @user = User.find_by_id(params[:user_id])

      if !@user.present?
        @status=false
        @msg = "not exist user"
      elsif !@user.authenticate(params[:password]).present?
        @status=false
        @msg="incorrect password"
      else

        user_id = params[:user_id].to_i
        name = params[:name].to_s
        bank = params[:bank].to_s
        account = params[:account].to_s
        amount = params[:amount].to_i
        #password = params[:password].to_s
        

        @current_reward = @user.current_reward

        if !(@current_reward >= amount)
          @status=false
          @msg="need more money"
        else

          # reward history write (all reward history)
          @reward = Reward.new
          @reward.user_id=user_id
          @reward.reward_type=7000               # reward_tpye : REFUND = 7000
          @reward.title="refund"
          @reward.sub_title="request"
          @reward.reward=(-1)*amount
          @reward.save

          # reward info writing (refund only history)
          @refund = RefundInfo.new
          @refund.user_id=user_id
          @refund.name=params=name
          @refund.bank=bank
          @refund.account=account
          @refund.amount=amount
          @refund.comment="request"
          @refund.save
         
          # User.current_reward update
          @user.update_attributes(:current_reward => @user.current_reward - amount)

        end
      end

    end
  end

  def get_purchase_list
    @status = true
    @msg = ""

    @user=User.find_by_id(params[:id])
    if !@user.present?
      @status=false
      @msg="not exist user_id"
    elsif !params[:coupon_type].present?
      @status=false
      @msg="not exist coupon_type params"
    elsif params[:coupon_type]!="1" && params[:coupon_type]!="0"
      @status=false
      @msg="invalid coupon_type"
    end

    if @status == true
      @coupons=MyCoupon.where('user_id = ? and coupon_type = ?', params[:id] ,params[:coupon_type]).order("created_at DESC")
      if @coupons.present?
        @product=[]
        @coupons.each do |p|
          tmp_hash = {}
          tmp_hash[:coupon_id] = p.coupon_id
          tmp_hash[:availability] = p.availability
          tmp_hash[:created_at] = p.created_at
          @product.push(tmp_hash)
        end
      end

    end
  end

  def show_cpx_list
    @status=true
    @msg=""

    user=User.find_by_id(params[:id])
    if !user.present?
      @status=false
      @msg="not exist user"
    else
      my_cpx_ad_ids=AdvertiseCpxLog.where(:user_id => params[:id], :act =>1).pluck(:ad_id).uniq
      if my_cpx_ad_ids.count==0
        @msg="not exist log"
      else
        @cpx_list=[]
        (0..my_cpx_ad_ids.count-1).each do |i|
          ad_id=my_cpx_ad_ids[i]
          my_cpx_recent=AdvertiseCpxLog.where('ad_id = ?',ad_id).order("created_at DESC").first
          ad_info=CpxAdvertisement.find_by_id(ad_id)
          if my_cpx_recent.act == 1
            if ad_info.remain <= 0
              act = 3
            else
              act = 1
            end
          else
            act = 2
          end
          tmp_hash={:id => my_cpx_recent.id, :ad_id => ad_id, :ad_type => my_cpx_recent.ad_type, :act => act, :created_at => my_cpx_recent.created_at, :name => ad_info.ad_name, :image => ad_info.ad_image.url, :reward => ad_info.reward}
          @cpx_list.push(tmp_hash)
        end
      end
    end
    @cpx_list.sort!{|a,b| b[:created_at] <=> a[:created_at]}
  end


  def my_home
    @status=true
    @msg=""
    @category=params[:category].to_i
    @period=params[:period].to_i
    @today=0

    @user=User.find_by_id(params[:id])
    if !@user.present?
      @status=false
      @msg="Not exist user"
    elsif !(@category>0 && @category<5) || !(@period==1 || @period==2)
      @status=false
      @msg="Category or Period error"
    else
      @product=[]
      @point=RankingPoint.find_by_id(params[:id])
      if @period==1 && @category==1
        @ranker=RankingPoint.order("week_1 DESC")
        @point=@point.week_1
        @remain=@ranker[0].week_1-@point
      elsif @period==1 && @category==2
        @ranker=RankingPoint.order("week_2 DESC")
        @point=@point.week_2
        @remain=@ranker[0].week_2-@point
      elsif @period==1 && @category==3
        @ranker=RankingPoint.order("week_3 DESC")
        @point=@point.week_3
        @remain=@ranker[0].week_3-@point
      elsif @period==1 && @category==4
        @ranker=RankingPoint.order("week_4 DESC")
        @point=@point.week_4
        @remain=@ranker[0].week_4-@point
      elsif @period==2 && @category==1
        @ranker=RankingPoint.order("mon_1 DESC")
        @point=@point.mon_1
        @remain=@ranker[0].mon_1-@point
      elsif @period==2 && @category==2
        @ranker=RankingPoint.order("mon_2 DESC")
        @point=@point.mon_2
        @remain=@ranker[0].mon_2-@point
      elsif @period==2 && @category==3
        @ranker=RankingPoint.order("mon_3 DESC")
        @point=@point.mon_3
        @remain=@ranker[0].mon_3-@point
      elsif @period==2 && @category==4
        @ranker=RankingPoint.order("mon_4 DESC")
        @point=@point.mon_4
        @remain=@ranker[0].mon_4-@point
      end
      (0..2).each do |i|
        @nickname=User.find_by_id(@ranker[i].id)
        @temp=Prize.where(:category => @category, :period => @period, :rank => (i+1))
        @temp_product={:id => @temp[0].id, :image => @temp[0].image, :nickname => @nickname.nickname}
        @product.push(@temp_product)
      end
      @user_stat=UserStage.find_by_user_id(params[:id])
      @leveu=@user_stat.level

      (0..@ranker.count-1).each do |i|    #SEARCHING MY RANK
        if @user.id == @ranker[i].id
          @my_rank=i
        end
      end

      @reward_history=Reward.where(:user_id => @user.id)  #Today's reward
      @today=0
      (0..@reward_history.count-1).each do |i|
        @date_type=@reward_history[i].created_at.to_date
        if @date_type == Date.today
          @today+=@reward_history[i].reward
        end
      end

      @level=UserStage.find_by_user_id(@user.id)
      @level=@level.level
      @attendance=@user.attendance_time
      @reward=@user.current_reward
      @sum=@user.total_reward 
      
    end
  end

  def get_prize_info
    @status=true
    @msg=""

    if !params[:id].present?
      @status=false
      @msg="not exist id params"
    else
      prize=Prize.find_by_id(params[:id])

      if !product.present?
        @status=false
        @msg="not exist prize"
      else
        @image = prize.image
        @content1 = prize.content1
        @content2 = prize.content2
        @content3 = prize.content3
      end
    end
  end


  def event_check
    @status = true
    @msg = ""

    @user = User.find_by_id(params[:id])
    if !@user.present?
      @status = false
      @msg = "Not exist user"
    elsif params[:act]=='3001' && params[:value].present?          ##example act
      @msg = "this is test"
      @value = params[:value]
    else
      @msg = "input proper act and value"
      @value = "99"
    end
  end


  def update_rank_point
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
