class DownloadsController < ApplicationController
  def index
    redirect_to "market://details?id=com.todpop.saltyenglish"
  end
end
