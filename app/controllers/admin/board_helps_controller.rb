class Admin::BoardHelpsController < Admin::ApplicationController
  def index
    @helps = BoardHelp.all
  end

  def show
    @help = BoardHelp.find(params[:id])
  end

  def new
    @help = BoardHelp.new
  end

  def create
    @help = BoardHelp.new(help_params)
    if @help.save
      redirect_to admin_board_helps_path, :notice => "Successfully created help."
    else
      render :action => 'new'
    end
  end

  def edit
    @help = BoardHelp.find(params[:id])
  end

  def update
    @help = BoardHelp.find(params[:id])
    if @help.update_attributes(help_params)
      redirect_to admin_board_helps_path, :notice  => "Successfully updated help."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @help = BoardHelp.find(params[:id])
    @help.destroy
    redirect_to admin_board_helps_url, :notice => "Successfully destroyed help."
  end

  private  

  def help_params
    params.require(:board_help).permit(:title, :content)
  end
end
