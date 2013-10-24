class Api::EtcController < ApplicationController
  def refund_info
    @status = true
    @msg = ""

    @reward = RewardSum.find_by_id(params[:id])

    if !@reward.present?
      @status = false
      @msg = "Not exist user"
    end

    if @status == true
      @current = @reward.current
      @content = @reward.content
    end

  end


  def refund
    @status = true
    @msg = ""
    @boolean=false

    if !params[:id] || !params[:name].present? || !params[:bank] || !params[:account] || !params[:sum] || !params[:password]
      @status=false
      @msg = "Please Input Data"
    else
      @user = User.find_by_id(params[:id])

      if !@user.present?
        @status=false
        @msg = "Not Exist ID"
      elsif !@user.authenticate(params[:password]).present?
        @status=false
        @msg="Incorrect Password"
      else
        @current = RewardSum.find(params[:id])

        if !(@current.current >= params[:sum])
          @status=false
          @msg="Need more money"
        else
          @reward = Reward.new
          @reward.user_id=params[:id]
          @reward.title=params[:sum]+"원 환급"
          @reward.sub_title="짭짤한 영어"
          @reward.reward_point=params[:sum]
          @reward.reward_type=401 ##TYPE REFUND => 401##

          @refund = RefundInfo.new
          @refund.user_id=params[:id]
          @refund.name=params[:name]
          @refund.bank=params[:bank]
          @refund.account=params[:account]
          @refund.sum=params[:sum]
          @refund.comment="X"
          @current.current = @current.current-params[:sum]
         
          @refund.save
          @reward.save
          @boolean=true 
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
    end
  end


  def get_product_info
    @status=true
    @msg=""

    product=Product.find_by_id(params[:id])

    if !@product.present?
      @status=false
      @msg="Not exist product"
    else
      @image = procduct.image
      @content1 = product.content1
      @content2 = product.content2
      @content3 = product.content3
    end
  end


end
