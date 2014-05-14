class Admin::PrizesController < Admin::ApplicationController
  def index
    @prizes = Prize.all.order("id desc")
    if params[:search_text].present?
      @prizes = @prizes.where('(prizes.date_start > ? && prizes.period = 1) || (prizes.date_start > ? && prizes.period = 2)', params[:search_text].to_date.at_beginning_of_week, params[:search_text].to_date.at_beginning_of_month).order("id desc")
    end

  end

  def show
    @prize = Prize.find(params[:id])
  end

  def new
    @prize = Prize.new
  end

  def create
    @prize = Prize.new(prize_params)
    if @prize.save
      redirect_to admin_prizes_path, :notice => "Successfully created prize."
    else
      render :action => 'new'
    end
  end

  def edit
    @prize = Prize.find(params[:id])
  end

  def update
    @prize = Prize.find(params[:id])
    if @prize.update_attributes(prize_params)
      redirect_to admin_prizes_path,  :notice  => "Successfully updated prize."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @prize = Prize.find(params[:id])
    @prize.destroy
    redirect_to admin_prizes_url, :notice => "Successfully destroyed prize."
  end
end

private 
def prize_params
    params.require(:prize).permit(:name, :category, :period, :rank, :date_start, :date_end, :image, :content1, :content2, :content3 )
end
