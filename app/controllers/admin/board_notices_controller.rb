# -*- encoding : utf-8 -*-
class Admin::BoardNoticesController < Admin::ApplicationController
  def index
    @notices = BoardNotice.all
  end

  def show
    @notice = BoardNotice.find(params[:id])
  end

  def new
    @notice = BoardNotice.new
  end

  def create
    @notice = BoardNotice.new(notice_params)
    if @notice.save
      redirect_to admin_board_notices_path, :notice => "Successfully created notice."
    else
      render :action => 'index'
    end
  end

  def edit
    @notice = BoardNotice.find(params[:id])
  end

  def update
    @notice = BoardNotice.find(params[:id])
    if @notice.update_attributes(notice_params)
      redirect_to admin_board_notices_path, :notice  => "Successfully updated notice."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @notice = BoardNotice.find(params[:id])
    @notice.destroy
    redirect_to admin_board_notices_url, :notice => "Successfully destroyed notice."
  end

  private
  def notice_params
    params.require(:board_notice).permit(:title, :content)
  end

end
