class Admin::CpdmAdvertisementsController < Admin::ApplicationController
  def index
    @cpdm_advertisements = CpdmAdvertisement.all
  end

  def show
    @cpdm_advertisement = CpdmAdvertisement.find(params[:id])
  end

  def new
    @cpdm_advertisement = CpdmAdvertisement.new
  end

  def create
    @cpdm_advertisement = CpdmAdvertisement.new(cpdm_advertisement_params)
    if @cpdm_advertisement.save
      redirect_to admin_cpdm_advertisements_path, :notice => "Successfully created cpdm advertisement."
    else
      render :action => 'new'
    end
  end

  def edit
    @cpdm_advertisement = CpdmAdvertisement.find(params[:id])
  end

  def update
    @cpdm_advertisement = CpdmAdvertisement.find(params[:id])
    if @cpdm_advertisement.update_attributes(cpdm_advertisement_params)
      redirect_to admin_cpdm_advertisements_path, :notice  => "Successfully updated cpdm advertisement."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @cpdm_advertisement = CpdmAdvertisement.find(params[:id])
    @cpdm_advertisement.destroy
    redirect_to admin_cpdm_advertisements_url, :notice => "Successfully destroyed cpdm advertisement."
  end


  private
 
  def cpdm_advertisement_params
    params.require(:cpdm_advertisement).permit(:kind, :count, :remain, :start_time, :end_time, :url, :priority, :ad_name)
  end
end