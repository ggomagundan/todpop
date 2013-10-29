class Api::EtcController < ApplicationController
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

  def purchase_list
    @status = true
    @msg = ""

    @user=User.find_by_id(params[:id])
    if !@user.present?
      @status=false
      @msg="Not exist user_id"
    elsif params[:category]=="1" || params[:category]=="0"
      @purchase=MyCoupon.where('user_id = ? and coupon_type = ?', params[:id] ,params[:category])
    else
      @status=false
      @msg="Invalid category"
    end
  end

  def show_cpx_list
    @status=true
    @msg=""

    @user=User.find_by_id(params[:id])
    if !@user.present?
      @status=false
      @msg="Not exist user"
    else
      @cpx_list=[]
      @cpx=AdvertiseCpxLog.where(:user_id => params[:id])
      if @cpx.count==0
        @msg="Not exist log"
      else
      (0..@cpx.count-1).each do |i|
        @ad=CpxAdvertisement.find_by_id(@cpx[i].ad_id)
        ##@data=@cpx[i].ad_id
        @data={:type => @cpx[i].ad_type, :name => @ad.ad_name, :reward => @ad.reward, :state => @cpx[i].act}
        @cpx_list.push(@data)
      end
    end
  end
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
      (0..2).each do |i|
      @temp=Product.where(:category => params[:category], :period => params[:period], :rank => (i+1))
      @temp_product={:Id => @temp[0].id, :Image => @temp[0].image}
      @product.push(@temp_product)
      end
      @user_stat=UserStage.find_by_user_id(params[:id])
      @level=@user_stat.level
      @attendance=@user.attendance_time
      @reward=Reward.where('user_id = ? and created_at >= ? and created_at <= ?', params[:id], Time.now.at_beginning_of_week, Time.now.at_end_of_week).pluck(:reward_point) 
      if @reward.count==0
        @msg="Not exist reward"
      else
        (0..@reward.count-1).each do |i|
          @today+=@reward[i]
        end
      end
      @reward=RewardSum.where(:id => params[:id]).pluck(:current)
      if !@reward.present?
        @reward=0
      end
      @sum=RewardSum.where(:id => params[:id]).pluck(:total)
      if !@sum.present?
        @sum=0
      end
    end
  end

  def get_product_info
    @status=true
    @msg=""

    if !params[:id].present?
      @status=false
      @msg="not exist id params"
    else
      product=Product.find_by_id(params[:id])

      if !product.present?
        @status=false
        @msg="not exist product"
      else
        @image = product.image
        @content1 = product.content1
        @content2 = product.content2
        @content3 = product.content3
      end
    end
  end


  def event_check
    @status=true
    @msg=""

    @user=User.find_by_id(params[:id])
    if !@user.present?
      @status=false
      @msg="Not exist user"
    elsif params[:act]=='3001'                       ##example act
      @user=User.find_by_id(params[:value])        ##example value
      @return=@user
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
