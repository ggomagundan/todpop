# -*- encoding : utf-8 -*-
class Api::PrizesController < ApplicationController

  def get_prize_info
    @status = true
    @msg  = ""
    
    if !params[:prize_id].present?
      @status = false
      @msg = "not exist prize_id parameter"
    elsif !(@info = Prize.find_by_id(params[:prize_id])).present?
      @status = false
      @msg = "not exist prize"
    end

  end
  
end
