class Admin::CpxAdvertisementsController < Admin::ApplicationController
  def index
    @cpx_advertisements = CpxAdvertisement.all
  end

  def show
    @cpx_advertisement = CpxAdvertisement.find(params[:id])
  end

  def new
    @cpx_advertisement = CpxAdvertisement.new
  end

  def create
    @cpx_advertisement = CpxAdvertisement.new(cpx_params)
    if @cpx_advertisement.save
      redirect_to admin_cpx_advertisements_path, :notice => "Successfully created cpx advertisement."
    else
      render :action => 'new'
    end
  end

  def edit
    @cpx_advertisement = CpxAdvertisement.find(params[:id])
  end

  def update
    @cpx_advertisement = CpxAdvertisement.find(params[:id])
    if @cpx_advertisement.update_attributes(cpx_params)
      redirect_to admin_cpx_advertisement_path, :notice  => "Successfully updated cpx advertisement."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @cpx_advertisement = CpxAdvertisement.find(params[:id])
    @cpx_advertisement.destroy
    redirect_to admin_cpx_advertisements_path, :notice => "Successfully destroyed cpx advertisement."
  end

  private
  def cpx_params
    params.require(:cpx_advertisement).permit(:kind, :start_time, :end_time, :count, :remain, :priority, :url, :name)
  end
end