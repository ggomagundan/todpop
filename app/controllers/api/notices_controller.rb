# -*- encoding : utf-8 -*-
class Api::NoticesController < ApplicationController
  def index
    @notices = Notice.all
  end

  def get_notices

    if params[:page].present?
      @page = params[:page]
    else
      @page = 1
    end

    @notices = Notice.order('id desc').page(@page).per(10)
    @status = true
    @msg = ""
  end
end
