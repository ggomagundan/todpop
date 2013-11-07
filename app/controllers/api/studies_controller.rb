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
    elsif params[:step] =='21' && (!params[:user_id] || !params[:level].present? || !params[:ox].present?)
      @status = false
      @msg = "not exist user_id or level or ox parameter"
    elsif params[:step] !='1' && (!params[:level].present? || !params[:ox].present?)
      @status = false
      @msg = "not exist level or ox parameter"
    elsif !(user=User.find_by_id(params[:user_id])).present?
      @status = false
      @msg = "not exist user"
    end

    if @status == true
      if params[:step] =='1'
        @level = 20
        @c_word = WordLevel.where(:level =>20).order("RAND()").first
        @wrong_word = []
        WordLevel.where(:level => 20).where.not(:id=> @c_word.id).order("RAND()").first(3).each do |w|
          @wrong_word.push(w.word.mean) 
        end
      else
        @level = level_word(params[:level], params[:step], params[:ox])
        @c_word = WordLevel.where(:level => @level).order("RAND()").first
        @wrong_word = []
        WordLevel.where(:level => @level).where.not(:id=> @c_word.id).order("RAND()").first(3).each do |w|
          @wrong_word.push(w.word.mean) 
        end

        # end of level_test : thus highest_level_reached recording
        if params[:step] == '21'
          user_id = params[:user_id].to_i
          category = params[:category].to_i
          
          if @level <= 15
            category = 1
          elsif @level <= 60
            category = 2
          elsif @level <= 120
            category = 3
          elsif @level <= 180
            category = 4
          else
            category = 4
          end
        
          user_stage = UserHighestLevel.where(:user_id => user_id).first
          if !user_stage.present?
            UserHighestLevel.create(:user_id => user_id, :category => category, :level => @level, :stage => 1)
          else
            user_stage.update_attributes(:category => category, :level => @level, :stage => 1)
          end
          #Update level_test column
          user.update_attributes(:level_test => 1)
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

    @word = WordLevel.where(:stage => params[:stage],:level => params[:level])

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
        if params[:is_new].to_i > 0 &&  UserStageBest.where('user_id = ? and created_at >= ?', params[:user_id], Date.today.to_time).count > AppInfo.last.new_stage_day_limit
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
            if i == exam_count - 1
              chain_point = chain_point + (chaining-1)*(0.25+0.025*(chaining.to_f - 2))
            end
          elsif chaining != 0
            chain_point = chain_point + (chaining-1)*(0.25+0.025*(chaining.to_f - 2))
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
      if @score >= AppInfo.last.two_medal.to_i
        @medal = 2
      elsif @score >= AppInfo.last.one_medal.to_i
        @medal = 1
      else 
        @medal = 0
      end

      record = UserStageBest.where(:stage => stage, :level => level, :user_id => user_id).first

      if record.present? && record.score_best.present?
        @rank_point = @rank_point / 2
           
        if @medal - record.n_medals_best == 2
          @reward = AppInfo.last.test_reward_max.to_i
        elsif @medal - record.n_medals_best == 1
          @reward = AppInfo.last.test_reward_max.to_i  / 2
        else
          @reward = 0
        end
      else
        if @medal == 2
          @reward = AppInfo.last.test_reward_max.to_i
        elsif @medal == 1
          @reward = AppInfo.last.test_reward_max.to_i / 2
        else
          @reward  = 0
        end
      end
      @rank_point = @rank_point.to_i


      if record.present?
        if record.n_medals_best < @medal
          record.update_attributes(:n_medals_best => @medal)
        end
        if record.score_best < @score
          record.update_attributes(:score_best => @score)
        end
           
      else
        UserStageBest.create(:level => level, :stage => stage, :user_id => user_id, :n_medals_best => @medal, :score_best => @score)
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
          elsif next_level == 61
            next_category = 3
          elsif next_level == 121
            next_category = 4
          elsif next_level > 180
            next_category = 4                 # Level limit
            next_level = 180
            next_stage = 10
          end
        end
      end

      user_stage = UserHighestLevel.where(:user_id => user_id).first
      if !user_stage.present?
        UserHighestLevel.create(:user_id => user_id, :category => next_category, :level => next_level, :stage => next_stage)
      else
        if  user_stage.category < next_category
          user_stage.update_attributes(:category => next_category, :level => next_level, :stage => next_stage)
        elsif  user_stage.level < next_level
          user_stage.update_attributes(:level => next_level, :stage => next_stage)
        elsif user_stage.level == next_level  && user_stage.stage < next_stage
          user_stage.update_attributes(:stage => next_stage)
        end 
      end

      # reward process ----------------------------------------------------------------
      if @reward > 0
        @token_user_id = user_id
        @token_reward_type = 1000 + category
        @token_title = "학습 장학금"
        @token_sub_title = "Level " + level.to_s + " - Stage " + stage.to_s
        @token_reward = @reward
        process_reward_general
      end

      # rank_point process
      if @rank_point > 0
        @token_user_id = user_id
        @token_point_type = 1000 + category
        @token_name = "학습 장학금" + " : Level " + level.to_s + " - Stage " + stage.to_s
        @token_point = @rank_point
        process_point_general
      end


      # consecutive taking a test update ----------------------------------------------
      @user = User.find(user_id)
      last_test = User.find(user_id).last_test

      if last_test.present?
        last_test_date = User.find(user_id).last_test.to_date

        if last_test_date == Date.today
        elsif last_test_date < Date.today && Date.today - last_test_date == 1
          @user.update_attributes(:daily_test_count => @user.daily_test_count + 1)
        else
          @user.update_attributes(:daily_test_count => 1)
        end
      else
        @user.update_attributes(:daily_test_count => 1)
      end

      # today taking a tes check ----------------------------------------------------
      @user.update_attributes(:last_test => Time.now)

      # Return only highest medal
      #if record.present? &&  @medal < record.n_medals_best
      #  @medal = record.n_medals_best
      #end

      # user_test_history log
      UserTestHistory.create(:user_id => user_id, :category => category, :level => level, :stage => stage, :n_medals => @medal, :score => @score, :reward => @reward, :rank_point => @rank_point)


    end
  end


end
