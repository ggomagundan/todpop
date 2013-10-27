class Admin::AppIntroduceVideosController < Admin::ApplicationController
  def index
    @id = AppIntroduceVideo.last.id
    redirect_to edit_admin_app_introduce_video_path(@id)
  end
  def edit
    @app_introduce_video = AppIntroduceVideo.find(params[:id])
  end

  def update
    @app_introduce_video = AppIntroduceVideo.find(params[:id])
    if @app_introduce_video.update_attributes(app_introduce_params)
      @app_introduce_video.update_attributes(:url => @app_introduce_video.video_url)
      render :action => 'edit', :notice  => "Successfully updated app introduce video."
    else
      render :action => 'edit'
    end
  end
  
  private
  def app_introduce_params
    params.require(:app_introduce_video).permit(:video, :url)
  end
end
