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
        Level.where(:level => 20).where.not(:id=> @c_word.id).first(3).each do |w|
          @wrong_word.push(w.word.mean) 
        end
      else
        @level = level_word(params[:level], params[:ox])
        @c_word = Level.where(:level => @level).order("RAND()").first
        @wrong_word = []
        Level.where(:level => @level).where.not(:id=> @c_word.id).first(3).each do |w|
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


  def level_word(cur_level, correct)
    cur_level = cur_level.to_i
    if correct == 'o' || correct ==1
      cur_level = cur_level+12
    else
      cur_level = cur_level-12
    end

    if cur_level < 1 
      cur_level = 1
    elsif cur_level > 24 
      cur_level = 24
    end
    return cur_level
  end
end
