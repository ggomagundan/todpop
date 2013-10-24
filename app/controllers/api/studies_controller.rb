# -*- encoding : utf-8 -*-
class Api::StudiesController < ApplicationController
  def index
    @studies = Study.all
  end
  
  def get_level_test_words
  
    @status = true
    @msg = ""

    if !params[:step].present? 
      @status = false
      @msg = "not exist stage parameter"
    elsif params[:step] !='1' && (!params[:level].present? || !params[:ox].present?)
      @status = false
      @msg = "not exist level or ox parameter"
    end

    if @status == true
      if params[:step] =='1'
        @level = 20
        @c_word = Level.where(:level =>20).order("RAND()").first
        @wrong_word = []
        Level.where(:level => 20).where.not(:id=> @c_word.id).order("RAND()").first(3).each do |w|
          @wrong_word.push(w.word.mean) 
        end
      else
        @level = level_word(params[:level], params[:step], params[:ox])
        @c_word = Level.where(:level => @level).order("RAND()").first
        @wrong_word = []
        Level.where(:level => @level).where.not(:id=> @c_word.id).order("RAND()").first(3).each do |w|
          @wrong_word.push(w.word.mean) 
        end


      end
    end

   
  end
  
  def get_level_words
    @status = true
    @msg = ""

    if !params[:stage].present? || !params[:level].present?
      @status = false
      @msg = "not exist stage or level params"
    end

    @word = Level.where(:stage => params[:stage],:level => params[:level])

    if !@word.present?
      @status = false
      @msg = "not exist words"
    end
  end



  def get_word_info
    @status = true
    @msg = ""
    
    if !params[:word].present?
      @status = false
      @msg = "not exist word parameter"   
    end

    @word = Word.find_by_name(params[:word])

    if !@word.present?
      @status = false
      @msg = "not exist #{params[:word]} word infomation"
    end
  end

  def level_word(cur_level, step, correct)
    cur_level = cur_level.to_i
    step = step.to_i

    d_level = 22-step
    if d_level > 12
      d_level = 12
    end

    if correct == 'o' || correct ==1
      cur_level = cur_level + d_level
    else
      cur_level = cur_level - d_level
    end

    if cur_level < 1
      cur_level = 1
    elsif cur_level > 150
      cur_level = 150
    end

    return cur_level
  end


  def get_possible_stage
    @status = true
    @msg = ""
      if !params[:user_id].present?
        @status = false
        @msg = "not exist nickname parameter"   
      elsif !params[:level].present? || !params[:stage].present?
        @status = false
        @msg = "not exist level or stage parameter"  
      elsif !params[:category].present?
        @status = false
        @msg = "not exist category parameter"  
      elsif !params[:is_new].present?
        @status = false
        @msg = "not exist isnew  parameter"  

      end

      if @status == true
        if params[:is_new].to_i > 0 &&  UserRecordBest.where('user_id = ? and created_at >= ?', params[:user_id], Date.today.to_time).count > AppInfo.last.day_limit
          @possible = false
          @msg = "limit over joy studying"
        else
          @possible = true
        end
      end



  end



  def send_word_result
    @status = true
    @msg = ""

    # parameters check ------------------------------------------------      
    if !params[:level].present? || !params[:stage].present?
      @status = false
      @msg = "not exist level or stage parameter"   
    elsif !params[:result].present?
      @status = false
      @msg = "not exist result  parameter"   
    elsif !params[:count].present?
      @status = false
      @msg = "not exist count  parameter"   
    elsif !params[:user_id].present?
      @status = false
      @msg = "not exist user_id  parameter"   
    elsif !params[:category].present?
      @status = false
      @msg = "not exist category parameter"   
    end

    # score & base rank_point calculation -----------------------------
    if @status == true
      stage = params[:stage].to_i
      level = params[:level].to_i
      result = params[:result].to_s
      exam_count = params[:count].to_i
      category = params[:category].to_i
      user_id = params[:user_id].to_i

      if stage==10
        @score = (result.to_f / exam_count *100).to_i
        @rank_point = result.to_f / exam_count * 20

      elsif stage >= 1 && stage < 10

        fast = 0
        middle  =0
        ircorrect = 0
    
        chaining = 0
        chain_point =0

        (0..result.length-1).each do |i|
          if result[i] == "2"
            fast = fast+1
          elsif result[i] == "1"
            middle = middle + 1
          else
            ircorrect = ircorrect + 1
          end

          if result[i] != "0" 
            chaining = chaining+1
            if i == exam_count
              chain_point = chain_point + chaining * ((chaining - 1).to_f / 2) * 0.25
            end
          else
            chain_point = chain_point + chaining * ((chaining - 1).to_f / 2) * 0.25
            chaining = 0
          end
        end 
    
        @score = (fast  + middle)  * 100 / exam_count
        rank_point_1 = fast + middle
        rank_point_2 = fast * 0.25

        rank_point_3 = chain_point 

        @rank_point = rank_point_1 + rank_point_2 + rank_point_3 

      else 
        @status = false
        @msg = "stage must 1~10"
      end 
    end

    if @status == true
        
      # medal calc , rank_point & reward calc based on history -----------------------------
      if @score >= AppInfo.last.two_star.to_i
        @medal = 2
      elsif @score >= AppInfo.last.one_star.to_i
        @medal = 1
      else 
        @medal = 0
      end

      record = UserRecordBest.where(:stage => stage, :level => level, :user_id => user_id).first

      if record.present? && record.record_point.present?
        @rank_point = @rank_point / 2
           
        if @medal - record.record_type == 2
          @reward = AppInfo.last.max_money.to_i
        elsif @medal - record.record_type == 1
          @reward = AppInfo.last.max_money.to_i  / 2
        else
          @reward = 0
        end
      else
        if @medal == 2
          @reward = AppInfo.last.max_money.to_i
        elsif @medal == 1
          @reward = AppInfo.last.max_money.to_i / 2
        else
          @reward  = 0
        end
      end
      @rank_point = @rank_point.to_i


      if record.present?
        if record.n_medals_best < @medal
          record.update_attributes(:n_medals_best => @medal)
        end
        if record.record_point < @score
          record.update_attributes(:score_best => @score)
        end
           
      else
        UserRecordBest.create(:level => level, :stage => stage, :user_id => user_id, :n_medals_best => @medal, :score_best => @score)
      end

      # highest level & stage record -------------------------------------------------
      next_category = category
      next_level = level
      next_stage = stage
      if @medal > 0
        next_stage = next_stage + 1
        if next_stage > 10
          next_stage = 1
          next_level = next_level + 1

          if next_level == 16
            next_category = 2
          elsif next_level = 61
            next_category = 3
          elsif next_level = 121
            next_category = 4
          elsif next_level > 180
            next_category = 4                 # Level limit
            next_level = 180
            next_stage = 10
          end
        end
      end

      user_stage = UserStage.where(:user_id => user_id).first
      if !user_stage.present?
        UserStage.create(:user_id => user_id, :category => next_category, :level => next_level, :stage => next_stage)
      else
          
        if user_stage.level == next_level  && user_stage.stage < next_stage
          user_stage.update_attributes(:stage => next_stage)
        end 
        if  user_stage.level < next_level
          user_stage.update_attributes(:level => next_level, :stage => next_stage)
        end

      end

      # reward log ----------------------------------------------------------------
      if @reward > 0
        Reward.create(:user_id => user_id, :reward_type => 1, :title => "문제", :reward_point => @reward)
      end


      # consecutive attendance update ----------------------------------------------
      @user = User.find(user_id)
      @last_con = User.find(user_id).last_connection.to_date

      if @last_con == Date.today
      elsif @last_con < Date.today && Date.today - last_con == 1
        @user.update_attributes(:attendance_time => @user.attendance_time + 1)
      else
        @user.update_attributes(:attendance_time => 1)
      end

      # today attendance check ----------------------------------------------------
      @user.update_attributes(:last_connection => Time.now)

      if record.present? &&  @medal < record.record_type
        @medal = record.record_type
      end
    end
  end
end
