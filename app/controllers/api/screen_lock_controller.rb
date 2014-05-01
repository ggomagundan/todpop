class Api::ScreenLockController < ApplicationController
  def word
    @status = true
    @msg = true

    if !params[:user_id].present?
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
      @word = Word.where('id in (?)', word_id).pluck(:name, :mean)
    end
  end

  def get_ad
    @status = true
    @msg = true
    @list = []

    if !params[:user_id].present?
      @status = false
      @msg = "not exist params"
    else
      ad = LockAdvertisement.first
      if ad.present?
        (201..202).each do |i|
          @list.push(:group => i, :ad_id => ad.id, :ad_type => ad.ad_type, :ad_image => ad.ad_image_url, :target_url => ad.target_url,
                    :reward => ad.reward, :point => ad.point)
        end
        @list.push(:group => 301, :ad_id => ad.id, :ad_type => ad.ad_type, :ad_image => ad.ad_image_url, :target_url => ad.target_url,
                   :reward => ad.reward, :point => ad.point)
        (301..304).each do |i|
          @list.push(:group => i, :ad_id => ad.id, :ad_type => ad.ad_type, :ad_image => ad.ad_image_url, :target_url => ad.target_url,
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
      ad_log.ad_type = params[:ad_type]
      ad_log.act = params[:act]
      if ad_log.save
        ad_remain = LockAdvertisement.find(params[:ad_id])
        ad_remain.update_attributes(:remain => ad_remain.remain-1)
        @result = true
      else
        @status = false
        @msg = "failed to save"
      end
    end
  end
end
