class Admin::CpdAdvertisementsController < ApplicationController
  def index
    @cpd_advertisements = CpdAdvertisement.all
  end

  def show
    @cpd_advertisement = CpdAdvertisement.find(params[:id])
  end

  def new
    @cpd_advertisement = CpdAdvertisement.new
  end

  def create
    @cpd_advertisement = CpdAdvertisement.new(cpd_advertisement_params)
    if @cpd_advertisement.save
      redirect_to admin_cpd_advertisements_path, :notice => "Successfully created cpd advertisement."
    else
      render :action => 'new'
    end
  end

  def edit
    @cpd_advertisement = CpdAdvertisement.find(params[:id])
  end

  def update
    @cpd_advertisement = CpdAdvertisement.find(params[:id])
    if @cpd_advertisement.update_attributes(cpd_advertisement_params)
      redirect_to admin_cpd_advertisements_path, :notice  => "Successfully updated cpd advertisement."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @cpd_advertisement = CpdAdvertisement.find(params[:id])
    @cpd_advertisement.destroy
    redirect_to admin_cpd_advertisements_url, :notice => "Successfully destroyed cpd advertisement."
  end
  
  private
  def cpd_advertisement_params
    params.require(:cpd_advertisement).permit(:kind, :count, :remain, :start_time, :end_time, :front_image, :back_image, :coupon_id, :priorityi, :ad_name)
  end
end
