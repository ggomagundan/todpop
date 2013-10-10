# -*- encoding : utf-8 -*-
class Api::NoticesController < ApplicationController
  def index
    @notices = Notice.all
  end

  def get_notices
    @notices = Notice.last(5).reverse
    @status = true
    @msg = ""
  end
end
