# -*- encoding : utf-8 -*-
class Api::PrizesController < ApplicationController

  def get_prize_info
    @status = true
    @msg  = ""
    
    if !params[:prize_id].present?
      @status = false
      @msg = "not exist prize_id parameter"
    end
  
    if @status == true
      @info = Prize.find_by_id(params[:prize_id])
    end

  end
  
end
