# -*- encoding : utf-8 -*-
class Api::ValidNicknamesController < ApplicationController
  def index
    
    if params[:nickname].present?
      @status = true
      @msg = ""
      @dupli = false
      if User.where(:nickname => params[:nickname]).present?
        @dupli = true
      end
    else
      @status = false
      @msg = "not exist nickname"
    end
  end
end
