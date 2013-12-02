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
      @msg = "not exist refund ment"
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

          # reward process
          @token_user_id=user_id
          @token_reward_type=7000               # reward_tpye : REFUND = 7000
          @token_title="refund"
          @token_sub_title="request"
          @token_reward=(-1)*amount

          # Refund request history (refund only)
          @token_name=name
          @token_bank=bank
          @token_account=account
          @token_comment="request"

          process_reward_general

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

    if !(user=User.find_by_id(params[:id])).present?
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
        @cpx_list.sort!{|a,b| b[:created_at] <=> a[:created_at]}
      end
    end
  end


  def my_home
    @status = true
    @msg = ""
 
    user=User.find_by_id(params[:id])
    if !user.present?
      @status=false
      @msg="not exist user"
    elsif !params[:category].present? || !params[:period].present?
      @status=false
      @msg="not exist category or period params"
    end

    if @status == true
      category = params[:category].to_i
      period = params[:period].to_i
      if !(category>0 && category<5) || !(period==1 || period==2)
        @status=false
        @msg="category or period error"
      end
    end

    if @status == true

      category = params[:category].to_s
      if params[:period] == "2"
        period = "mon_"
      else
        period = "week_"
      end

      tmp = "@ranker = RankingCurrent.order(\"" + period + category + " DESC\")"
      eval(tmp)

      @prize=[]
      (0..2).each do |i|
        if @ranker[i].present?
          nickname = User.find_by_id(@ranker[i].id).nickname
        else
          nickname = nil
        end
        temp = Prize.where('category = ? and period = ? and rank = ? and date_start <= ? and date_end >= ?',
                           category, params[:period], i+1, Date.today, Date.today)
        if temp.present?
          tmp_hash = {:id => temp[0].id, :image => temp[0].image, :nickname => nickname}
          @prize.push(tmp_hash)
        end
      end

      @my_level = UserHighestLevel.find_by_user_id(params[:id]).level
      @my_rank = @ranker.index{|r| r.id == params[:id].to_i} + 1
      @daily_test_count = user.daily_test_count

      my_point_all = RankingCurrent.find_by_id(params[:id])
      tmp = "@my_point = my_point_all." + period + category
      eval(tmp)

      tmp = "@remain_to1st = @ranker[0]." + period + category + ' - @my_point'
      eval(tmp)

      @reward_today = RewardLog.where('user_id = ? and created_at >= ? and created_at < ? and reward > ?', user.id, Date.today.to_time, Date.tomorrow.to_time, 0).pluck(:reward).sum
      @reward_current = user.current_reward
      @reward_total = user.total_reward
      @character_url = user.character
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


  def get_coupon_free_info
    @status=true
    @msg=""

    if !params[:id].present?
      @status=false
      @msg="not exist coupon_id params"
    else
      coupon=CouponFreeInfo.find_by_id(params[:id])

      if !coupon.present?
        @status=false
        @msg="not exist coupon"
      else
        @name = coupon.name
        @place = coupon.place
        @valid_start = coupon.valid_start
        @valid_end = coupon.valid_end
        @bar_code = coupon.bar_code
        @image = coupon.image
        @information = coupon.information
      end
    end
  end



  def event_check
    @status=true
    @msg=""

    @user=User.find_by_id(params[:id])
    if !@user.present?
      @status=false
      @msg="not exist user"
    elsif params[:act]=='3001' && params[:value].present?          ##example act
      @msg = "this is act=3001 test"
      @value = params[:value]

      if params[:value]=="100"

        # reward
        @token_user_id = params[:id]
        @token_reward_type = 9999
        @token_title = "test title"
        @token_sub_title = "test sub"
        @token_reward = 9999
        process_reward_general

        # rank_point
        @token_user_id = params[:id]
        @token_point_type = 9999
        @token_name = "test name"
        @token_point = 9998
        process_point_general

      end

    else
      @msg = "enter proper act and value"
      @value = "99"
    end
  end




  def character
    @status=true
    @msg=""
    
    if !params[:id]
      @msg="not exist user_id"
    else
      user=User.find_by_id(params[:id])
      if params[:url]
        user.update_attributes(:character => params[:url])
      end
      @url=user.character
    end
  end

  def main_notice
    @status = true
    @msg = ""

    if !AppInfo.last.android_version.present?
      @status = false
      @msg = "not exist android_version"
    elsif !MentList.find_by_kind("notice").present?
      @status = false
      @msg = "not exist notice"
    else
      @android_version = AppInfo.last.android_version
      @ment = MentList.where(:kind => "notice").last.content
    end
  end

end
