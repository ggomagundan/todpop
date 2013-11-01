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

    #inter = 1,2,3,4
    #@value.split(",").map { |s| s.to_i }


    if params[:mem_no].present?
      if !params[:email].present? && !params[:facebook].present?
        @status = false
        @msg = "not exist email or facebook"
      elsif params[:email].present? && !params[:password].present?
        @status = false
        @msg = "email exist but no password"
      end
    else
      if !params[:email].present? && !params[:facebook].present?
        @status = false
        @msg = "not exist email or facebook"
      elsif !params[:nickname].present?
        @status = false
        @msg = "not exist nickname"
      elsif User.where(:nickname => params[:nickname]).present?
        @status = false
        @msg = "nickname duplicate"
      elsif !params[:mobile].present?
        @status = false
        @msg = "not exist mobile"
      elsif User.where(:mobile => params[:mobile]).present?
        @status = false
        @msg = "mobile duplicate"
      end
    end

    if @status == true
      
      if params[:mem_no].present?
        # cross Join
        @user = User.find_by_id(params[:mem_no])
        if @user.present?
          @status = false
          @msg = "not exist user_id"
        else
          if params[:email].present?
            @user.password = params[:password]
            @user.password_confirmation = params[:password]
            @user.is_set_facebook_password = 1
          end
          @user.update_attributes(user_params)
        end
      else
        # new Join
        @user = User.new(user_params)

        if params[:email].present? 
          @user.password = params[:password]
          @user.password_confirmation = params[:password] 
          @user.is_set_facebook_password = 1
        elsif params[:facebook].present?
          @user.password = "dummypassword"
          @user.password_confirmation = "dummypassword"
          @user.is_set_facebook_password = 0
        end

        # Create User's Database
        
      end

      if @status == true
        if @user.save
          @msg = "complete"
          if !params[:mem_no].present?
            a = RankingCurrent.new
            a.id = @user.id
            a.save
          end
        else
          @status = false
          @msg = "join save error"
        end
      end
    end
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
      @status = true
      @msg = ""
      @result = true
      if User.where(:nickname => params[:nickname]).present?
        @result = false
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
    end

    if @status == true

      if params[:period] == "1"
        period = "mon_"
      else
        period = "week_"
      end
      
      tmp = "@list = RankingCurrent.order(\"" + period + params[:category] + " DESC\")"
      eval(tmp)

      @user_info = []
      (1..[10,@list.size].min).each do |i|
        user = User.find_by_id(@list[i-1].id) 
        name = user.nickname
        tmp = "@user_point = @list[i-1]." + period + params[:category]
        eval(tmp)
        image = "http://www.1stwebdesigner.com/wp-content/uploads/2009/07/free-twitter-icons/designreviver-free-twitter-social-icon.jpg"

        rank = {:rank => i, :name => name, :score => @user_point, :image => image}
        @user_info.push(rank)
      end

      my_id = User.find_by_nickname(params[:nickname]).id
      my_idx = @list.index{|l| l.id == my_id}
      tmp = "@my_point = @list[my_idx]." + period + params[:category]
      eval(tmp)
      image = "http://www.1stwebdesigner.com/wp-content/uploads/2009/07/free-twitter-icons/designreviver-free-twitter-social-icon.jpg"

      @mine = {:rank => my_idx+1, :name => params[:nickname], :score => @my_point, :image => image}
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
    end
  end


  private
    def user_params
      params.permit(:email, :facebook, :nickname, :recommend, :sex, :birth, :address, :mobile, :interest)
    end

end
