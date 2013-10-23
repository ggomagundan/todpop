class Admin::HelpsController < Admin::ApplicationController
  def index
    @helps = Help.all
  end

  def show
    @help = Help.find(params[:id])
  end

  def new
    @help = Help.new
  end

  def create
    @help = Help.new(help_params)
    if @help.save
      redirect_to admin_helps_path, :notice => "Successfully created help."
    else
      render :action => 'new'
    end
  end

  def edit
    @help = Help.find(params[:id])
  end

  def update
    @help = Help.find(params[:id])
    if @help.update_attributes(help_params)
      redirect_to admin_helps_path, :notice  => "Successfully updated help."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @help = Help.find(params[:id])
    @help.destroy
    redirect_to admin_helps_url, :notice => "Successfully destroyed help."
  end

  private  

  def help_params
    params.require(:help).permit(:title, :content)
  end
end
