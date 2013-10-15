class Admin::AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all
  end

  def show
  end

  def new
    @advertisement = Advertisement.new

    @ad_type = params[:kind]
  end

  def create
    @advertisement = Advertisement.new(advertisement_params)
    if @advertisement.save
      redirect_to admin_advertisements_path, :notice => "Successfully created advertisement."
    else
      render :action => 'new'
    end
  end

  def edit
   @advertisement = Advertisement.find(params[:id])

    if @advertisement.kind == 1
      @cpd = CpdAd.find(@advertisement.ads_num)
    elsif @advertisement.kind == 2
     @cpd = CpdAd.find(@advertisement.ads_num)
    elsif @advertisement.kind == 3
      @cpd = CpdAd.find(@advertisement.ads_num)
    elsif @advertisement.kind == 4
      @cpd = CpdAd.find(@advertisement.ads_num)
    end

  end

  def update
    @advertisement = Advertisement.find(params[:id])
    if @advertisement.kind == 1
      @cpd = CpdAd.find(@advertisement.ads_num)
    elsif @advertisement.kind == 2
      @cpd = CpdAd.find(@advertisement.ads_num)
    elsif @advertisement.kind == 3
      @cpd = CpdAd.find(@advertisement.ads_num)
    elsif @advertisement.kind == 4
      @cpd = CpdAd.find(@advertisement.ads_num)
    end
    if @advertisement.update_attributes(advertisement_params)
      if @advertisement.kind == 1
        if @cpd.update_attributes(cpd_params)
          redirect_to admin_advertisements_path, :notice  => "Successfully updated advertisement."
        else
          render :action => 'edit'
        end
      elsif @advertisement.kind == 2
        redirect_to admin_advertisements_path, :notice  => "Successfully updated advertisement."
      elsif @advertisement.kind == 3
        redirect_to admin_advertisements_path, :notice  => "Successfully updated advertisement."
      elsif @advertisement.kind == 4
        redirect_to admin_advertisements_path, :notice  => "Successfully updated advertisement."
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @advertisement = Advertisement.find(params[:id])
    @advertisement.destroy
    redirect_to admin_advertisements_url, :notice => "Successfully destroyed advertisement."
  end

private
  def advertisement_params
    params.require(:advertisement).permit(:kind, :start_time, :end_time, :count, :remain)
  end

  def cpd_params
    params.require(:advertisement).permit(:front_image, :back_image, :coupon_id, :priority)
  end

end
