class Admin::ScreenLocksController < Admin::ApplicationController
  #before_action :set_admin_screen_lock, only: [:show, :edit, :update, :destroy]

  # GET /admin/screen_locks
  # GET /admin/screen_locks.json
  def index
    @lock_advertisements = LockAdvertisement.all
    @lock_cor_name = Client.all
  end

  # GET /admin/screen_locks/1
  # GET /admin/screen_locks/1.json
  def show
    @lock_advertisement = LockAdvertisement.find(params[:id])
  end

  # GET /admin/screen_locks/new
  def new
    @screen_lock = LockAdvertisement.new
    @client_arr = []
    client_all = Client.all
    for i in 1..client_all.size
      client_str = "Cor Name : " + client_all[i-1].cor_name.to_s + " | Name : " + client_all[i-1].name.to_s
      @client_arr.push([].push(client_str, client_all[i-1].id))
    end
  end

  # GET /admin/screen_locks/1/edit
  def edit
    @screen_lock = LockAdvertisement.find(params[:id])
    @client_arr = []
    client_all = Client.all
    for i in 1..client_all.size
      client_str = "Cor Name : " + client_all[i-1].cor_name.to_s + " | Name : " + client_all[i-1].name.to_s
      @client_arr.push([].push(client_str, i))
    end
  end

  # POST /admin/screen_locks
  # POST /admin/screen_locks.json
  def create
    @lock_advertisement = LockAdvertisement.new(lock_params)
    if @lock_advertisement.save
      redirect_to admin_screen_locks_path, :notice => "Successfully created screen lock advertisement."
    else
      render :action => 'new'
    end
  end

  # PATCH/PUT /admin/screen_locks/1
  # PATCH/PUT /admin/screen_locks/1.json
  def update
    @lock_advertisement = LockAdvertisement.find(params[:id])
    if @lock_advertisement.update_attributes(lock_params)
      redirect_to admin_screen_locks_path, :notice => "Successfully created screen lock advertisement."
    else
      render :action => 'edit'
    end
  end

  # DELETE /admin/screen_locks/1
  # DELETE /admin/screen_locks/1.json
  def destroy
    @lock_advertisement = LockAdvertisement.find(params[:id])
    @lock_advertisement.destroy
    redirect_to admin_screen_locks_path, :notice => "Successfully destroyed screen lock advertisement."
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def lock_params
      params.require(:lock_advertisement).permit(:ad_name, :cli_id, :ad_type, :contract, :remain, :basic_show_price, :action_price, :reward, :point, :pay_type, :target_url, :ad_image, :start_date, :end_date, :priority)
    end
end
