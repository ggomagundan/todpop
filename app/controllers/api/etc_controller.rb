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

end
