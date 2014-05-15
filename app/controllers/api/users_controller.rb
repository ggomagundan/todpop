# -*- encoding : utf-8 -*-
class Api::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @users = User.all
  end

  def show
    if params[:id].present?
      @user = User.find(params[:id])
    end
  end

  def sign_up
    @status = true
    @msg = ""
    @code=0

    #inter = 1,2,3,4
    #@value.split(",").map { |s| s.to_i }

    # Log start
    invalue = "start" 
    log = LogSignUp.new
    invalue = invalue + " / " + "address="   + params[:address]   if params[:address].present?
    invalue = invalue + " / " + "birth="     + params[:birth]     if params[:birth].present?
    invalue = invalue + " / " + "email="     + params[:email]     if params[:email].present?
    invalue = invalue + " / " + "facebook="  + params[:facebook]  if params[:facebook].present?
    invalue = invalue + " / " + "interest="  + params[:interest]  if params[:interest].present?
    invalue = invalue + " / " + "mem_no="    + params[:mem_no]    if params[:mem_no].present?
    invalue = invalue + " / " + "mobile="    + params[:mobile]    if params[:mobile].present?
    invalue = invalue + " / " + "nickname="  + params[:nickname]  if params[:nickname].present?
    invalue = invalue + " / " + "password="  + params[:password]  if params[:password].present?
    invalue = invalue + " / " + "recommend=" + params[:recommend] if params[:recommend].present?
    invalue = invalue + " / " + "sex="       + params[:sex]       if params[:sex].present?
    invalue = invalue + " / " + "device="       + params[:device]       if params[:device].present?
    invalue = invalue + " / " + "android_ver="       + params[:android_version]       if params[:android_version].present?
    invalue = invalue + " / " + "operator="       + params[:operator]       if params[:operator].present?
    invalue = invalue + " / " + "region="       + params[:operator_region]       if params[:operator_region].present?
    log.invalue = invalue
    log.save 
    # --------


    if params[:mem_no].present?
      if !params[:email].present? && !params[:facebook].present?
        @status = false
        @msg = "not exist email or facebook"
      elsif params[:email].present? && !params[:password].present?
        if User.find_by_id(params[:mem_no]).is_set_facebook_password == 0
          @status = false
          @msg = "email exist but no password"
        end
      end
    else
      if !params[:email].present? && !params[:facebook].present?
        @status = false
        @msg = "not exist email or facebook"
      elsif params[:email].present? && !params[:password].present?
        @status = false
        @msg = "not exist password"
      elsif !params[:nickname].present?
        @status = false
        @msg = "not exist nickname"
      elsif User.where(:nickname => params[:nickname]).present?
        @status = false
        @msg = "nickname duplicate"
      elsif !params[:mobile].present?
        @status = false
        @msg = "not exist mobile"
        @code=71
      elsif User.where(:mobile => params[:mobile]).present?
        @status = false
        @msg = "mobile duplicate"
        @code=72
      end
    end

    if @status == true
      
      if params[:mem_no].present?
        # cross Join
        @user = User.find_by_id(params[:mem_no])
        if !@user.present?
          @status = false
          @msg = "not exist user_id"
        else
          if params[:email].present?
            @user.password = params[:password]
            @user.password_confirmation = params[:password]
            @user.is_set_facebook_password = 1
            @user.update_attributes(user_params)
          elsif params[:facebook].present?
            @user.update_attributes(:facebook => params[:facebook])
            if params[:address].present?
              @user.update_attributes(:f_address => params[:address])
            end
            if params[:birth].present?
              @user.update_attributes(:birth => params[:birth])
            end
            if params[:sex].present?
              @user.update_attributes(:sex => params[:sex])
            end
          end
        end
      else
        # new Join
        @user = User.new(user_params)

        if params[:email].present? 
          @user.password = params[:password]
          @user.password_confirmation = params[:password] 
          @user.is_set_facebook_password = 1
        elsif params[:facebook].present?
          @user.address = nil
          @user.f_address = params[:address]
          @user.sex = params[:sex]
          @user.birth = params[:birth]
          @user.password = "dummypassword"
          @user.password_confirmation = "dummypassword"
          @user.is_set_facebook_password = 0
        end

        @user.screen_lock=1
        @user.android_ver=params[:android_version] if params[:android_version].present?
        @user.region=params[:operator_region] if params[:operator_region].present?

        # Create User's Database
        
      end

      if @status == true
        begin
          if @user.save
            @msg = "complete"
            if !params[:mem_no].present?
              a = RankingCurrent.new
              a.id = @user.id
              b = RankingCurrent.first
              if b.present?
                a.week_start = b.week_start
                a.week_end   = b.week_end
                a.mon_start  = b.mon_start
                a.mon_end    = b.mon_end
              else
                a.week_start = Date.today.beginning_of_week
                a.week_end   = Date.today.end_of_week
                a.mon_start  = Date.today.beginning_of_month
                a.mon_end    = Date.today.end_of_month
              end
              a.save
              ##################### Create user stage info table ##########################
              u = UserStageInfo.new
              info = "Y"
              (2..1800).each do
                info += "x"
              end
              info[150]="Y"		# middle 1st stage open
              info[600]="Y"
              info[1200]="Y"
              u.user_id = @user.id
              u.stage_info = info
              u.save
            end
          else
            @status = false
            @msg = "join save error"
          end
        rescue Exception => e
          #logger.error e.message
          #e.backtrace.each { |line| logger.error line }

          log.elog = e.message
          log.save

          @status = false
          @msg = "incorrect nickname"
        end
      end
    end

    # recommned reward & rank_point update
    if @status == true && !params[:mem_no].present? && params[:recommend].present?

      # Reward & Point DEFINITIOM !!!! --------------------  <-- Change here !!!!
      old_user_reward = 0;
      new_user_reward = 0;
      old_user_point = 0;			# temporary 2014/01/16
      new_user_point = 0;			# temporary 2014/01/16
 
      # reward process
      if old_user_reward > 0
        old_user = User.find_by_nickname(params[:recommend])
        if old_user.present?
          @token_user_id = old_user.id
          @token_reward_type = 3100
          @token_title = "추천인 보너스"
          @token_sub_title = "기존유저"
          @token_reward = old_user_reward
          process_reward_general
        end
      end

      if new_user_reward > 0
        @token_user_id = @user.id
        @token_reward_type = 3200
        @token_title = "추천인 보너스"
        @token_sub_title = "신규유저"
        @token_reward = new_user_reward
        process_reward_general
      end


      # rank_point process
      if old_user_point > 0
        old_user = User.find_by_nickname(params[:recommend])
        if old_user.present?
          @token_user_id = old_user.id
          @token_point_type = 3100
          @token_name = "추천인 보너스 : 기존유저"
          @token_point = old_user_point
          process_point_general
        end
      end

      if new_user_point > 0
        @token_user_id = @user.id
        @token_point_type = 3200
        @token_name = "추천인 보너스 : 신규유저"
        @token_point = new_user_point
        process_point_general
      end
    end



    # log close --------------
    log.status = @status
    log.msg = @msg
    log.save
    # -----------------------
  end

  def re_sign_up
    @status = true
    @msg = ""

    if !params[:mobile].present?
      @status = false
      @msg = "mobile duplicate"
    end

    if @status == true
      
      @user = User.find_by_mobile(params[:mobile])

      if !@user.present?
        @status = false
        @msg = "존재하지 않는 번호"        
      end
    end

  end

  def sign_in
    @status = true
    @msg = ""

    if (!params[:email].present? || !params[:password].present?) && !params[:facebook].present? 
      @status = false
      @msg = "not exist email/password or facebook parameter"
      if params[:user_id].present?
        @status = true
        @msg = "user info"
      end
    end

    if @status == true
      
      if params[:email].present?
        @user = User.find_by_email(params[:email])
        if !@user.present?
          @msg = "wrong email or password"
          @status= false
        elsif !@user.authenticate(params[:password]).present?
          @msg = "wrong email or password"
          @status= false
        end
      elsif params[:facebook].present?
        @user = User.find_by_facebook(params[:facebook])
        if !@user.present?
          @msg = "not exist user"
          @status = false
        end
      elsif params[:user_id].present?
        @user = User.find_by_id(params[:user_id])
        if !@user.present?
          @msg = "not exist user"
          @status = false
        end
      end
      
      #if @status == true
      #  @user.update_attributes(:last_test => Time.now)   # def of last_test != login 
      #end

    end

  end


  def check_nickname_exist
    @status = true
    @msg = ""

    if params[:nickname].present?
      begin
        @status = true
        @msg = ""
        @result = true
        if User.where(:nickname => params[:nickname]).present?
          @result = false
        end
      rescue Exception => e
        logger.error e.message
        e.backtrace.each { |line| logger.error line }

        @status = false
        @msg = "incorrect nickname"
      end
    else
      @status = false
      @msg = "not exist nickname prameter"
    end
  end

  


  def check_mobile_exist
    @status = true
    @msg = ""

    if !params[:mobile].present?
      @status = false
      @msg = "not exist mobile params"
    end

    if @status == true
      @user = User.find_by_mobile(params[:mobile])
      if !@user.present?
        @status = false
        @msg = "not exist mobile"
      end
    end
    

  end
  
  def check_recommend_exist
    @status = true
    @msg = ""

    if !params[:recommend].present?
      @status = false
      @msg = "not exist recommend params"
    end

    if @status == true
      @result = true
      if !User.where(:nickname => params[:recommend]).present?
        @result = false
        @msg = "not exist nickname"
      end
    end
  end

  def check_facebook_exist
    @status = true
    @msg = ""

    if !params[:facebook].present?
      @status = false
      @msg = "not exist facebook params"
    end

    if @status == true
      @result = true
      if User.where(:facebook => params[:facebook]).present?
        @result = false
      end
    end
  end

  def check_email_exist
    @status = true
    @msg = ""

    if !params[:email].present?
      @status = false
      @msg = "not exist email params"
    end

    if @status == true
      @result = true
      if User.where(:email => params[:email]).present?
        @result = false
      end
    end
  end

  
  def address_list
    @status = true
    @msg = ""
    if !params[:depth].present? || params[:depth] == "1"
      @addr = Address.all.pluck(:depth1).uniq
    elsif params[:depth].present? && params[:depth] == "2" 
      if params[:s].present?
        @addr = Address.where(:depth1 => params[:s]).pluck(:depth1, :depth2).uniq
      else
        @status = false
        @msg = "not exist s parmeter"
      end

    else
      @status = false
      @msg = "not exist any parameter"
    end
  end

  def resign_up_info
    @status = true
    @msg = ""
    
    if !params[:mobile].present?
      @status = false
      @msg = "not exist mobile parameter"
    else
      @user = User.find_by_mobile(params[:mobile])   
      if !@user.present?
        @status = false
        @msg = "not exist any users"
      end
    end
  
  end


  def get_users_score
    @status = true
    @msg = ""

    if !params[:category].present? || !params[:period].present? || !params[:nickname].present?
      @status = false
      @msg = "not exist category or period or nickname parameter"
    else
      @token_user_id = User.find_by_nickname(params[:nickname])
      update_rank_point_table
    end

    if @status == true

      if params[:period] == "2"
        period_ = "mon_"
        period = "Mon"
      else
        period_ = "week_"
        period = "Week"
      end

      if params[:category] == "1"
        category = "A"
      elsif params[:category] == "2"
        category = "B"
      elsif params[:category] == "3"
        category = "C"
      else
        category = "D"
      end
     
=begin 
      tmp = "@list = RankingCurrent.order(\"" + period_ + params[:category] + " DESC\")"
      eval(tmp)

      @user_info = []
      (1..10).each do |i|
        if !@list[i-1].present?
          name = "짭짭짭"
          @user_point = 0
          image = "1"
        else
          user = User.find_by_id(@list[i-1].id)
          name = user.nickname
          tmp = "@user_point = @list[i-1]." + period_ + params[:category]
          eval(tmp)
          image = user.character
        end

        rank = {:rank => i, :name => name, :score => @user_point, :image => image}
        @user_info.push(rank)
      end

      my_id = User.find_by_nickname(params[:nickname]).id
      my_idx = @list.index{|l| l.id == my_id}
      tmp = "@my_point = @list[my_idx]." + period_ + params[:category]
      eval(tmp)
      image = User.find_by_nickname(params[:nickname]).character

      @mine = {:rank => my_idx+1, :name => params[:nickname], :score => @my_point, :image => image}
    end
=end
    rank_tmp=""
    q = "rank_tmp = RankingTemp" + period + category + ".first(10)"
    eval(q)
    if rank_tmp.present?
      @user_info = []
      (1..10).each do |i|
        if rank_tmp[i-1] != nil
          #user = rank_tmp[i-1].user_id
          @user_point = rank_tmp[i-1].score
          if User.find(rank_tmp[i-1].user_id).present?
            name = User.find(rank_tmp[i-1].user_id).nickname
            image = User.find(rank_tmp[i-1].user_id).character

            rank = {:rank => i, :name => name, :score => @user_point, :image => image}
            @user_info.push(rank)
          else
            rank = {:rank => i, :name => "짭짤이", :score => @user_point, :image => 1}
          end
        else
          @user_point=0
          rank = {:rank => i, :name => "짭짤이", :score => @user_point, :image => 1}
        end
      end
    end

    my_id = User.find_by_nickname(params[:nickname]).id
    image = User.find_by_nickname(params[:nickname]).character
    myidx=0

    p = "myidx = RankingTemp" + period + category + ".find_by_user_id(" + my_id.to_s + ")"
    eval(p)

    r = "@my_point = RankingCurrent.find_by_id(my_id)." + period_ + params[:category].to_s
    eval(r)

    if myidx==nil
      #@my_point = 0
      @mine = {:rank => 0, :name => params[:nickname], :score => @my_point, :image => image}
    else
      #@my_point = myidx.score
      @mine = {:rank => myidx.id, :name => params[:nickname], :score => @my_point, :image => image}
    end
    

    @current_time = DateTime.now
    c_time=DateTime.now
    @finish_time = RankingCurrent.first
    if params[:period]=="1"
      @finish_time = @finish_time.week_end.end_of_day
    elsif params[:period]=="2"
      @finish_time = @finish_time.mon_end.end_of_day
    end
    @time_diff = %w(year month day hour minute second).map do |interval|
      distance_in_seconds = (@finish_time.to_i - c_time.to_i).round(1)
      delta = (distance_in_seconds / 1.send(interval)).floor
      delta -= 1 if c_time + delta.send(interval) > @finish_time
      c_time += delta.send(interval)
      delta
    end

  end
  end


  def get_users_point_list
    @status = true
    @msg = ''
    
      @user = User.find(params[:id])
      if !@user.present?
        @status = false
        @msg = "not exist this user"
      else
        @point = PointLog.where(:user_id => @user.id).reverse
      end

  end


  def delete_user
    @status = true
    @msg = "success"

    @user = User.find_by_id(params[:id])
    if !@user.present?
      @status = false
      @msg = "not exist user"
    elsif !params[:mobile].present? || !params[:password].present?
      @status = false
      @msg = "not exist mobile or password parameter"
    elsif @user.mobile != params[:mobile]
      @status = false
      @msg = "incorrect mobile"
    elsif !@user.authenticate(params[:password]).present?
      @status = false
      @msg = "incorrent password"
    end

    if @status == true

      # copy first (namually)
      job_copy = InactiveUser.new(:id => @user.id, :email => @user.email, :facebook => @user.facebook,
                           :nickname => @user.nickname, :recommend => @user.recommend, :sex => @user.sex,
                           :birth => @user.birth, :address => @user.address, :mobile => @user.mobile,
                           :interest => @user.interest, :level_test => @user.level_test,
                           :is_set_facebook_password => @user.is_set_facebook_password,
                           :daily_test_count => @user.daily_test_count, :current_reward => @user.current_reward,
                           :total_reward => @user.total_reward, :is_admin => @user.is_admin,
                           :last_test => @user.last_test).save
                           # skipped : password_digest, created_at, updated_at

      if job_copy
        if @user.destroy
          @ranking_current = RankingCurrent.find_by_id(params[:id])
          if !@ranking_current.destroy
            @msg = "fail to delete user's current raking"
          end
        else
          @status = false
          @msg = "fail to delete user"  
        end
      else
        @status = false
        @msg = "fail to delete user"  
      end
    end
  end 


  def change_password
    @status = true
    @msg = "success"

    @user = User.find_by_id(params[:id])
    if !@user.present?
      @status = false
      @msg = "not exist user"
    elsif !params[:nickname].present? || !params[:mobile].present?
      @status = false
      @msg = "not exist nickname or mobile parameter"
    elsif !params[:current_password].present? || !params[:new_password].present?
      @status = false
      @msg = "not exist current_password or new_password"
    elsif @user.nickname != params[:nickname]
      @status = false
      @msg = "incorrect nickname "
    elsif @user.mobile != params[:mobile]
      @status = false
      @msg = "incorrect mobile number"
    elsif !@user.authenticate(params[:current_password]).present?
      @status = false
      @msg = "incorrect current password"
    else
      @user.password = params[:new_password]
      @user.password_confirmation = params[:new_password]
      if @user.save
      else
        @status = false
        @msg = "not success user update. please retry"
      end
    end
  end

  def setting_facebook_password
    @status = true
    @msg = ""

    @user = User.find_by_id(params[:id])
    
    if !@user.present?
      @status = false
      @msg = "not exist user"
    elsif !params[:nickname].present? || !params[:mobile].present?
      @status = false
      @msg = "not exist nickname or mobile parameter"
    elsif @user.nickname != params[:nickname]
      @status = false
      @msg = "incorrect nickname"
    elsif @user.mobile != params[:mobile]
      @status = false
      @msg = "incorrect mobile number"
    elsif !@user.facebook.present?
      @status = false
      @msg = "not facebook user"
    else
      @pass = SecureRandom.random_number(10000)
      @user.password = @pass
      @user.password_confirmation = @pass
      if @user.save
        if UserMailer.change_pw_facebook(@user).deliver
          @status = true
          @msg = "success"
        else
          @status = false
          @msg = "failed to send email"
        end
      else
        @status = false
        @msg = "not success user update. please retry"  
      end
    end
  end

  def facebook_change_pw
    @user = User.find_by_id(params[:id])
    
    if request.post?
      if !params[:user][:password].present?
        render :file => "#{Rails.root}/public/404"
      else
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password]
        @user.is_set_facebook_password = 1
        if @user.save
          @status = true
        else
          @status = false
        end
      end
    else 
      if !@user.present? || @user.password_digest != params[:tmp]
        render :file => "#{Rails.root}/public/404"
      end
    end
  end

  def is_set_facebook_password
    @status = true
    @msg = ""

    @user = User.find_by_id(params[:id])

    if !@user.present?
      @status = false
      @msg = "not exist user"
    end

    if @status == true
      if @user.is_set_facebook_password == 1
        @set_password = true
      else
        @set_password = false
      end
    end

  end

  def get_reward_list
    @user = User.find_by_id(params[:id])

    @status = true
    @msg = ""

    if !@user.present?
      @status = false
      @msg = "not exist user"
    end


    if params[:page].present?
      @page = params[:page]
    else
      @page = 1
    end

    if @status == true
      @list = RewardLog.where(:user_id => params[:id]).order('created_at desc').page(@page).per(10)
    end

    
  end


  def get_attendance_time
    @user = User.find_by_id(params[:id])

    @status = true
    @msg = ""

    if !@user.present?
      @status = false
      @msg = "not exist user"
    end

    if @status == true

      # update daily_test_count
      last_test = @user.last_test
      if last_test.present?
        date_gap = Date.today - last_test.to_date
        if date_gap >= 2
          @user.update_attributes(:daily_test_count => 0)
        end
      else
        @user.update_attributes(:daily_test_count => 0)    # never took exam
      end

      # data
      @attendance_time = @user.daily_test_count
      @attendance_reward = @user.daily_test_reward
    end
  end

  def get_qpcon_coupons

    @user = User.find_by_id(params[:id])

    @status = true
    @msg = ""

    @coupons = Order.where(:user_id => @user.id)


  end


  private
    def user_params
      params.permit(:email, :facebook, :nickname, :recommend, :sex, :birth, :address, :f_address, :mobile, :interest, :device, :operator)
    end

end
