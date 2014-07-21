class Api::ScreenLockController < ApplicationController
  def word
    @status = true
    @msg = true

    if params[:pro].present? && params[:pro].to_i == 1
      if params[:category].to_i == 0
        word_id = WordLevel.order("rand()").pluck(:word_id).uniq[0..9]
      elsif params[:category].to_i == 1
        word_id = WordLevel.where('level < ?', 16).order("rand()").pluck(:word_id).uniq[0..9]
      elsif params[:category].to_i == 2
        word_id = WordLevel.where('level > ? and level < ?', 15, 61).order("rand()").pluck(:word_id).uniq[0..9]
      elsif params[:category].to_i == 3
        word_id = WordLevel.where('level > ? and level < ?', 60, 121).order("rand()").pluck(:word_id).uniq[0..9]
      elsif params[:category].to_i == 4
        word_id = WordLevel.where('level > ?', 120).order("rand()").pluck(:word_id).uniq[0..9]
      end
      @word = Word.where('id in (?)', word_id).order("rand()").pluck(:name, :mean)
    elsif !params[:user_id].present?
      @status = false
      @msg = "Need User_ID"
    else
      dup_check = AppInfo.first.test_reward_max
      history = UserTestHistory.where('user_id = ? and stage not in (10) and reward = ?', params[:user_id].to_i, dup_check).last(3)
      if history.size < 2
        word_id = WordLevel.where('id >= 3961 and id <= 7920').order("rand()").pluck(:word_id).uniq[0..9]
      else
        lv = []
        stg = []
        history.each do |i|
          lv.push(i.level)
          stg.push(i.stage)
        end
        word_id = WordLevel.where('level in (?) and stage in (?)', lv, stg).order("rand()").pluck(:word_id).uniq[0..9]
      end
      @word = Word.where('id in (?)', word_id).order("rand()").pluck(:name, :mean)
      tmp_q=LockAdvertisement.where(:group => 412).order("rand()").first
      @quiz={:id => tmp_q.id, :image => tmp_q.ad_image_url, :target_url => tmp_q.target_url, :reward => tmp_q.reward, :point => tmp_q.point} if tmp_q.present?
    end
  end

  def get_ad
    @status = true
    @msg = true
    @list = []
    type = [421, 422, 431, 432, 433, 434, 441, 442]

    if !params[:user_id].present?
      @status = false
      @msg = "not exist params"
    else
      (0..type.count-1).each do |i|
        
        tmp = LockAdvertisement.where(:group => type[i])
        ad = tmp.where('start_date <= ? and end_date >= ?', Date.today, Date.today).order("priority").first
        if ad.present?
          @list.push(:group => type[i], :ad_id => ad.id, :ad_type => ad.ad_type, :ad_image => ad.ad_image_url, :target_url => ad.target_url,
                     :reward => ad.reward, :point => ad.point)
        end

        if type[i]==431
          tmp_1 = LockAdvertisement.where(:group => type[i])
          ad = tmp_1.where('start_date <= ? and end_date >= ?', Date.today, Date.today).order("priority").second
          if ad.present?
            @list.push(:group => type[i], :ad_id => ad.id, :ad_type => ad.ad_type, :ad_image => ad.ad_image_url, :target_url => ad.target_url,
                       :reward => ad.reward, :point => ad.point)
          end
        end

      end



=begin
      ad = LockAdvertisement.first
      if ad.present?
        (201..202).each do |i|
          @list.push(:group => i, :ad_id => ad.id, :ad_type => ad.ad_type, :ad_image => "/uploads/lock_advertisement/ad_image/1/#{i}.png", :target_url => ad.target_url,
                    :reward => ad.reward, :point => ad.point)
        end
        @list.push(:group => 301, :ad_id => ad.id, :ad_type => ad.ad_type, :ad_image => "/uploads/lock_advertisement/ad_image/1/300.png", :target_url => ad.target_url,
                   :reward => ad.reward, :point => ad.point)
        (301..304).each do |i|
          @list.push(:group => i, :ad_id => ad.id, :ad_type => ad.ad_type, :ad_image => "/uploads/lock_advertisement/ad_image/1/#{i}.png", :target_url => ad.target_url,
                    :reward => ad.reward, :point => ad.point)
        end
        (401..402).each do |i|
          @list.push(:group => i, :ad_id => ad.id, :ad_type => ad.ad_type, :ad_image => ad.ad_image_url, :target_url => ad.target_url,
                    :reward => ad.reward, :point => ad.point)
        end

        @msg = "success"
      else
        @msg = "not exist advertisement"
      end
=end
    end
  end

  def set_ad_log
    @status = true
    @msg = true

    if !params[:user_id].present? || !params[:ad_id].present? || !params[:ad_type].present?
      @status = false
      @msg = "not exist parameter"
    else
      ad_log = AdvertiseLockLog.new
      ad_log.user_id = params[:user_id]
      ad_log.ad_id = params[:ad_id]
      ad_log.group = params[:group]
      ad_log.ad_type = params[:ad_type]
      ad_log.act = 2
      ad_log.act=1 if AdvertiseLockLog.where('user_id = ? and ad_id = ? and act = 1', params[:user_id], params[:ad_id]).count==0

      if ad_log.save
        ad_remain = LockAdvertisement.find(params[:ad_id])
        ad_remain.update_attributes(:remain => ad_remain.remain-1)
        @result = true
        
        if ad_log.act == 1
          @token_user_id = params[:user_id]
          @token_reward = ad_remain.reward
          @token_point = ad_remain.point
          if @token_reward.present? && @token_reward > 0 
            @token_sub_title = ad_remain.id.to_s + " : " + ad_remain.ad_name
            @token_reward_type = 6000 + ad_remain.ad_type              # reward_type : LockScreen = 6000 + ad_type
            @token_title = "Lock Screen"
            process_reward_general
          elsif @token_point.present? && @token_point > 0
            @token_name = "LockScreen : " + ad_remain.id.to_s + " : " + ad_remain.ad_name
            @token_point_type = 6000 + ad_remain.ad_type               # point_type : LockScreen = 6000 + ad_type
            process_point_general
          end
        end
      else
        @status = false
        @msg = "failed to save"
      end
    end
  end

  def lock_state
    @status = true
    @msg = ""

    if !params[:user_id].present?
      @status = false
      @msg = "not exist user id"
    elsif !params[:state].present?
      @status = false
      @msg = "not exist state"
    end
    
    if @status == true
      @state = User.find(params[:user_id])
      @state.update_attributes(:screen_lock => params[:state])
      @msg = params[:state]=="1" ? "on":"off"
    end
  end

  def get_test
    @status = true
    @msg = ""
    @list = []

    tmp = LockAdvertisement.where(:group => 413)
        ad = tmp.where('start_date <= ? and end_date >= ?', Date.today, Date.today).order("priority").first
        if ad.present?
          @list.push(:group => 413, :ad_id => ad.id, :ad_type => ad.ad_type, :ad_image => ad.ad_image_url, :test_image => ad.reserve_image_url, :target_url => ad.target_url,
                     :reward => ad.reward, :point => ad.point)
        end
  end

  def exam_words
    @status = true
    @msg = ""
    @list = []

    if !params[:ad_id].present?
      @status = false
      @msg = "not exsit ad_id"
    elsif !params[:user_id].present?
      @status = false
      @msg = "not exist user_id"
    elsif params[:score].present?
      ad = LockAdvertisement.where('id = ?', params[:ad_id]).first
      word = ExamWords.where('title = ? and part = ?', ad.ad_name, ad.target_url).first
      log = ExamWordsLog.where('exam_no = ? and part = ? and user_id = ? and score is null', word.exam_no, word.part, params[:user_id]).last
      @msg = "part-#{word.part} of #{word.title} score : #{params[:score]}"
      if log.present?
        log.update_attributes(:score => params[:score])
      else
        log = ExamWordsLog.new
        log.exam_no = ad.exam_no
        log.part = ad.part
        log.user_id = params[:user_id]
        log.score = params[:score]
        log.save
      end
      if ExamWordsLog.where('exam_no = ? and part = ? and user_id = ? and score is not null', word.exam_no, word.part, params[:user_id]).count == 1
          @token_user_id = params[:user_id]
          @token_reward = ad.reward
          @token_point = ad.point
          if @token_reward.present? && @token_reward > 0 
            @reward = @token_reward
            @token_sub_title = ad.id.to_s + " : " + ad.ad_name
            @token_reward_type = 6000 + ad.ad_type              # reward_type : LockScreen = 6000 + ad_type
            @token_title = "Lock Screen"
            process_reward_general
          elsif @token_point.present? && @token_point > 0
            @point = @token_point
            @token_name = "LockScreen : " + ad.id.to_s + " : " + ad.ad_name
            @token_point_type = 6000 + ad.ad_type               # point_type : LockScreen = 6000 + ad_type
            process_point_general
          end
      end
    else
      ad = LockAdvertisement.where('id = ?', params[:ad_id]).first
      if ad.present?
        @msg = "part-#{ad.target_url} of #{ad.ad_name}"
        words = ExamWords.where('title = ? and part = ?', ad.ad_name, ad.target_url).order("rand()").limit(50).pluck(:word, :mean, :q_no)

        words.each do |w|
          @list.push(:word => w[0], :mean => w[1], :q_no => w[2])
        end

        @count = words.count

        if words.present?
          log = ExamWordsLog.new
          log.exam_no = ExamWords.where('title = ? and part = ?', ad.ad_name, ad.target_url).first.exam_no
          log.user_id = params[:user_id].to_i
          log.part = ad.target_url.to_i
          log.save
        else
          @msg = "not exist words"
          @status = false
        end
      else
        @status = false
        @msg = "invalid ad_id"
      end
    end
  end
end
