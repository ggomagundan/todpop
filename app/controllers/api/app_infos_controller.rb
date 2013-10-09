class Api::AppInfosController < ApplicationController

  def get_fast_pivot_time
    @pivot = AppInfo.last
    @status = true
    @msg = ""
  end
end
