class ApiController < ApplicationController

  def test
    @value = params[:param]
  end
end
