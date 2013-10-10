# -*- encoding : utf-8 -*-
class ApiController < ApplicationController

  def test
    @value = params[:param]
  end

  def get_intro_movie
    @status = true
    @msg = ""
    @url = AppIntroduceVideo.last.url
  end





end
