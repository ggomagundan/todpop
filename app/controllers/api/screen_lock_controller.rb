class Api::ScreenLockController < ApplicationController
  def word
    @status = true
    @msg = true

    if !params[:user_id].present?
      @status = false
      @msg = "User_ID"
    else
      history = UserTestHistory.where('user_id = ?', params[:user_id].to_i).last(3)
      if history.size == 0
        word_id = WordLevel.where('id = ?', rand(3961..7920))[0].word_id
      else
        rnd = rand(0..history.size-1)
        lv = history[rnd].level
        stg = 9
        stg = history[rnd].stage if history[rnd].stage != 10
        idx = WordLevel.where('level = ? and stage = ?', lv, stg)
        word_id = idx[rand(0..idx.length-1)].word_id
      end
      @word = Word.find_by_id(word_id).name
      @mean = Word.find_by_id(word_id).mean
    end
  end
end
