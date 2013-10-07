class Admin::NoticesController < ApplicationController
  def index
    @notices = Notice.all
  end

  def show
    @notice = Notice.find(params[:id])
  end

  def new
    @notice = Notice.new
  end

  def create
    @notice = Notice.new(notice_params)
    if @notice.save
      redirect_to [:admin, @notice], :notice => "Successfully created notice."
    else
      render :action => 'index'
    end
  end

  def edit
    @notice = Notice.find(params[:id])
  end

  def update
    @notice = Notice.find(params[:id])
    if @notice.update_attributes(notice_params)
      redirect_to [:admin, @notice], :notice  => "Successfully updated notice."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy
    redirect_to admin_notices_url, :notice => "Successfully destroyed notice."
  end

    def notice_params
      params.require(:notice).permit(:title, :content)
    end

end
