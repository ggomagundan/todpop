class Admin::ScreenLocksController < Admin::ApplicationController
  #before_action :admin_screen_locks_path, only: [:show, :edit, :update, :destroy]
  #before_action :set_admin_screen_lock, only: [:show, :edit, :update, :destroy]

  # GET /admin/screen_locks
  # GET /admin/screen_locks.json
  def index
    if !params[:group].present?
      @lock_advertisements = LockAdvertisement.all
      @r=1
    else
      @lock_advertisements = LockAdvertisement.where(:group => params[:group])
      @r=2 if params[:group]=="412"
      @r=3 if params[:group]=="413"
      @r=4 if params[:group]=="421"
      @r=5 if params[:group]=="422"
      @r=6 if params[:group]=="431"
      @r=7 if params[:group]=="432"
      @r=8 if params[:group]=="433"
      @r=9 if params[:group]=="434"
      @r=10 if params[:group]=="441"
      @r=11 if params[:group]=="442"
    end
    @lock_cor_name = Client.all
    group = [413, 421, 422, 431, 432, 433, 434, 441, 442]
    @today = LockAdvertisement.where('start_date <= ? and end_date >= ?', Date.today, Date.today).pluck(:group).uniq
    @tomorrow = LockAdvertisement.where('start_date <= ? and end_date >= ?', Date.today+1.day, Date.today+1.day).pluck(:group).uniq
    @today = ((group-@today).count==0) ? 0 : group-@today
    @tomorrow = ((group-@tomorrow).count==0) ? 0 : group-@tomorrow
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
    @cpd_arr = []
    @cpdm_arr = []
    @cpx_arr = []
    client_all = Client.all
    for i in 1..client_all.size
      client_str = "Cor Name : " + client_all[i-1].cor_name.to_s + " | Name : " + client_all[i-1].name.to_s
      @client_arr.push([].push(client_str, client_all[i-1].id))
    end

    ad_all = CpdAdvertisement.all
    for j in 1..ad_all.size
      ad_str = "Name : " + ad_all[j-1].ad_name.to_s + " | Type : " + ad_all[j-1].ad_type.to_s
      @cpd_arr.push([].push(ad_str, ad_all[j-1].id))
    end

    ad_all = CpdmAdvertisement.all.pluck(:ad_name, :ad_type, :id)
    for i in 1..ad_all.size
      ad_str = "Name : " + ad_all[i-1][0].to_s + " | Type : " + ad_all[i-1][1].to_s
      @cpdm_arr.push([].push(ad_str, ad_all[i-1][2]))
    end

    ad_all = CpxAdvertisement.all.pluck(:ad_name, :ad_type, :id)
    for i in 1..ad_all.size
      ad_str = "Name : " + ad_all[i-1][0].to_s + " | Type : " + ad_all[i-1][1].to_s
      @cpx_arr.push([].push(ad_str, ad_all[i-1][2]))
    end
  end

  # GET /admin/screen_locks/1/edit
  def edit
    @screen_lock = LockAdvertisement.find(params[:id])
    @client_arr = []
    @cpd_arr = []
    @cpdm_arr = []
    @cpx_arr = []
    client_all = Client.all
    for i in 1..client_all.size
      client_str = "Cor Name : " + client_all[i-1].cor_name.to_s + " | Name : " + client_all[i-1].name.to_s
      @client_arr.push([].push(client_str, client_all[i-1].id))
    end

    ad_all = CpdAdvertisement.all.pluck(:ad_name, :ad_type, :id)
    for i in 1..ad_all.size
      ad_str = "Name : " + ad_all[i-1][0].to_s + " | Type : " + ad_all[i-1][1].to_s
      @cpd_arr.push([].push(ad_str, ad_all[i-1][2]))
    end

    ad_all = CpdmAdvertisement.all.pluck(:ad_name, :ad_type, :id)
    for i in 1..ad_all.size
      ad_str = "Name : " + ad_all[i-1][0].to_s + " | Type : " + ad_all[i-1][1].to_s
      @cpdm_arr.push([].push(ad_str, ad_all[i-1][2]))
    end

    ad_all = CpxAdvertisement.all.pluck(:ad_name, :ad_type, :id)
    for i in 1..ad_all.size
      ad_str = "Name : " + ad_all[i-1][0].to_s + " | Type : " + ad_all[i-1][1].to_s
      @cpx_arr.push([].push(ad_str, ad_all[i-1][2]))
    end
  end

  # POST /admin/screen_locks
  # POST /admin/screen_locks.json
  def create
    @lock_advertisement = LockAdvertisement.new(lock_params)
    #@lock_advertisement.update_attributes(:linked_id => params[:linked_id]) if params[:link]!=0
    if params[:lock_advertisement][:link] == '0'
      @lock_advertisement.ad_type=params[:ad_type] if params[:ad_type].present?
      @lock_advertisement.contract=params[:contract] if params[:contract].present?
      @lock_advertisement.remain=params[:remain] if params[:remain].present?
      @lock_advertisement.basic_show_price=params[:basic_show_price] if params[:basic_show_price].present?
      @lock_advertisement.action_price=params[:action_price] if params[:action_price].present?
      @lock_advertisement.target_url=params[:target_url] if params[:target_url].present?
      @lock_advertisement.pay_type=params[:pay_type] if params[:pay_type].present?
    else
      @lock_advertisement.linked_id=params[:lock_advertisement][:linked_id].to_i if params[:lock_advertisement][:linked_id].present?
    end
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
    if params[:lock_advertisement][:link] == '0'
      @lock_advertisement.ad_type=params[:ad_type].to_i if params[:ad_type].present?
      @lock_advertisement.contract=params[:contract].to_i if params[:contract].present?
      @lock_advertisement.remain=params[:remain].to_i if params[:remain].present?
      @lock_advertisement.basic_show_price=params[:basic_show_price].to_i if params[:basic_show_price].present?
      @lock_advertisement.action_price=params[:action_price].to_i if params[:action_price].present?
      @lock_advertisement.target_url=params[:target_url].to_s if params[:target_url].present?
      @lock_advertisement.pay_type=params[:pay_type] if params[:pay_type].present?
    else
      @lock_advertisement.linked_id=params[:lock_advertisement][:linked_id].to_i if params[:lock_advertisement][:linked_id].present?
    end
    #@lock_advertisement.update_attributes(:linked_id => params[:linked_id]) if params[:link]!=0
    #if params[:lock_advertisement][:link] != 0
    #  ad=CpdAdvertisement.where('id=?',params[:lock_advertisement][:linked_id]).first if params[:lock_advertisement][:link]==1
    #  ad=CpdmAdvertisement.where('id=?',params[:lock_advertisement][:linked_id]).first if params[:lock_advertisement][:link]==2
    #  ad=CpxAdvertisement.where('id=?',params[:lock_advertisement][:linked_id]).first if params[:lock_advertisement][:link]==3
    #end
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
      params.require(:lock_advertisement).permit(:ad_name, :link, :cli_id, :group, :reward, :point, :ad_image, :start_date, :end_date, :priority)
    end
end
