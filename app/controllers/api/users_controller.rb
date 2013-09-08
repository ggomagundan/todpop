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

    if (!params[:email].present? && !params[:facebook].present?) || !params[:password].present? 
      @status = false
      @msg = "not exist email or password parameter"
    end

    if @status == true
      
      if params[:email].present?
        @user = User.find_by_email(params[:email])
      elsif params[:facebook].present?
        @user = User.find_by_facebook(params[:facebook])
      end
      
      if !@user.present?
        @msg = "존재하지 않는 사용자입니다."
        @status = false
      elsif @user.present? && !@user.authenticate(params[:password]).present?
        @msg = "비밀번호가 틀렸습니다."
        @status= false
      else 
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
        @msg = "존재하지 않는 번호"
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
        @addr = Address.where(:depth1 => params[:s])
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
        @rank = {:rank => i, :name => "name#{i}", :score => (11-i)*100, :image => "http://www"}
        @user_info.push(@rank)
      end
      @mine = {:rank => 30, :name => "xxxx", :score => 20, :image => "http://www"}
    end

  end
  

  private
  def user_params
    params.permit(:email, :facebook, :nickname, :recommend, :sex, :birth, :address, :mobile, :interest )
  end

end
