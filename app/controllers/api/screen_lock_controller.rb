class Api::ScreenLockController < ApplicationController
  def word
    @status = true
    @msg = true

    if !params[:user_id].present?
      @status = false
      @msg = "User_ID"
    else
      history = UserTestHistory.where('user_id = ? and stage not in (10)', params[:user_id].to_i).last(3)
      if history.size == 0
        word_id = WordLevel.where('id = ?', rand(3961..7920))[0].word_id
      else
        rnd = rand(0..history.size-1)
        lv = history[rnd].level
        stg = history[rnd].stage
        idx = WordLevel.where('level = ? and stage = ?', lv, stg)
        word_id = idx[rand(0..idx.length-1)].word_id
      end
      @word = Word.find_by_id(word_id).name
      @mean = Word.find_by_id(word_id).mean
    end
  end

  def get_ad
    @status = true
    @msg = true

    if !params[:user_id].present?
      @status = false
      @msg = "not exist params"
    else
      ad = LockAdvertisement.first
      if ad.present?
        @ad_id = ad.id
        @ad_type = ad.ad_type
        @ad_image = ad.ad_image_url
        @target_url = ad.target_url
        @reward = ad.reward
        @point = ad.point
        @msg = "success"
      else
        @msg = "not exist advertisement"
      end
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
      ad_log.ad_id = params[:ad_id]
      ad_log.ad_type = params[:ad_type]
      ad_log.act = params[:act]
      if ad_log.save
        ad_remain = LockAdvertisement.find(params[:ad_id])
        ad_remain.update_attributes(:remain => ad_remain.remain-1)
      else
        @status = false
        @msg = "failed to save"
      end
    end
  end
end
