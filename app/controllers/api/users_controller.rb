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

    if !params[:email].present? && !params[:facebook].present?
      @status = false
      @msg = "not exist 이메"
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

    if @status == true
      
      if params[:mem_no].present?
        # cross Join
        @user = User.find(params[:mem_no])
        @user.update_attributes(user_params)

      else
     
        # new Join
        @user = User.new(user_params) 
       
        @user.password = params[:password]
        @user.password_confirmation = params[:password] 
      
      end

      if @user.save!
        @msg = "complete"
      else
        @status = false
        @msg = "join error"
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
      
      if @status == true
        @user.update_attributes(:late_connection => Time.now)
      end

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
        @status = false
        @msg = "존재하지 않는 닉네임"
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

    if !params[:category].present? || !params[:nickname].present?
      @status = false
      @msg = "not exist category or email parameter"
    end

    if @status == true
      @user_info = []
      (1..10).each do |i|
        @rank = {:rank => i, :name => "name#{i}", :score => (11-i)*100, :image => "http://www.1stwebdesigner.com/wp-content/uploads/2009/07/free-twitter-icons/designreviver-free-twitter-social-icon.jpg"}
        @user_info.push(@rank)
      end
      @mine = {:rank => 30, :name => "xxxx", :score => 20, :image => "http://www.1stwebdesigner.com/wp-content/uploads/2009/07/free-twitter-icons/designreviver-free-twitter-social-icon.jpg"}
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
        @point = Point.where(:user_id => @user.id).reverse
      end

  end


  def delete_user
    @status = true
    @msg = ""

    @user = User.find(params[:id])
    if !@user.present?
      @status = false
      @msg = "not exist user"
    elsif !params[:nickname].present? || !params[:mobile].present?
      @status = false
      @msg = "not exist nickname or mobile parameter"
    elsif @user.nickname != params[:nickname]
      @status = false
      @msg = "discorrect nickname "
    elsif @user.mobile != params[:mobile]
      @status = false
      @msg = "discorrect mobile number "
    else
      if @user.destroy
        @result = true
      else
        @status = false
        @msg = "not success user delete. please retry"  
      end
    end
  end 


  def change_password
    @status = true
    @msg = ""

    @user = User.find(params[:id])
    if !@user.present?
      @status = false
      @msg = "not exist user"
    elsif !params[:nickname].present? || !params[:mobile].present?
      @status = false
      @msg = "not exist nickname or mobile parameter"
    elsif @user.nickname != params[:nickname]
      @status = false
      @msg = "discorrect nickname "
    elsif @user.mobile != params[:mobile]
      @status = false
      @msg = "disrrcorrect mobile number "
    elsif @user.authenticate(params[:current_password]).present?
      @status = false
      @msg = "discorrect current password"
    else
      @user.password = params[:password]
      @user.password_confirmation = params[:password] 
      if @user.save
        @result = true
      else
        @status = false
        @msg = "not success user update. please retry"  
      end
    end
  end 

  def setting_facebook_password
    @status = true
    @msg = ""

    @user = User.find(params[:id])
    if !@user.present?
      @status = false
      @msg = "not exist user"
    elsif !params[:nickname].present? || !params[:mobile].present?
      @status = false
      @msg = "not exist nickname or mobile parameter"
    elsif @user.nickname != params[:nickname]
      @status = false
      @msg = "discorrect nickname "
    elsif @user.mobile != params[:mobile]
      @status = false
      @msg = "disrrcorrect mobile number "
    else
      @pass = SecureRandom.random_number(10000)
      @user.password = @pass
      @user.password_confirmation = @pass
      if @user.save
        #require mail to using @user.password_digest 
        @result = true
      else
        @status = false
        @msg = "not success user update. please retry"  
      end
    end
  end 
  private
  def user_params
    params.permit(:email, :facebook, :nickname, :recommend, :sex, :birth, :address, :mobile, :interest )
  end

end
