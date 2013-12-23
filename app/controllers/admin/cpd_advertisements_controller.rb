class Admin::CpdAdvertisementsController < Admin::ApplicationController
  def index
    @cpd_advertisements = CpdAdvertisement.all
    @cpd_cor_name = Client.all
  end

  def show
    @cpd_advertisement = CpdAdvertisement.find(params[:id])
  end

  def new
    @cpd_advertisement = CpdAdvertisement.new
    @client_arr = []
    client_all = Client.all
    for i in 1..client_all.size
      client_str = "Cor Name : " + client_all[i-1].cor_name.to_s + " | Name : " + client_all[i-1].name
      @client_arr.push([].push(client_str, client_all[i-1].id))
    end
  end

  def create
    @cpd_advertisement = CpdAdvertisement.new(cpd_advertisement_params)
    if @cpd_advertisement.save
      if params[:cpd_advertisement][:ad_type] == '102' 
        coupon = CouponFreeInfo.new
        if params[:c_name].present?
          coupon.name = params[:c_name]
        end
        if params[:c_place].present?
          coupon.place = params[:c_place]
        end
        if params[:c_valid_start].present?
          coupon.valid_start = params[:c_valid_start]
        end
        if params[:c_valid_end].present?
          coupon.valid_end = params[:c_valid_end]
        end
        if params[:c_bar_code].present?
          coupon.bar_code = params[:c_bar_code]
        end
        if params[:c_image].present?
          coupon.image = params[:c_image]
        end
        if params[:c_information].present?
          coupon.information = params[:c_information]
        end

        if coupon.save
          @cpd_advertisement.update_attributes(:coupon_id => coupon.id)
          redirect_to admin_cpd_advertisements_path, :notice => "Successfully created cpd advertisement."
        end
      else
        redirect_to admin_cpd_advertisements_path, :notice => "Successfully created cpd advertisement."
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @client_arr = []
    client_all = Client.all
    for i in 1..client_all.size
      client_str = "Cor Name : " + client_all[i-1].cor_name.to_s + " | Name : " + client_all[i-1].name.to_s
      @client_arr.push([].push(client_str, i))
    end
    @cpd_advertisement = CpdAdvertisement.find(params[:id])
    if @cpd_advertisement.ad_type == 102 && @cpd_advertisement.coupon_id.present?
      @cpd_coupon = CouponFreeInfo.find(@cpd_advertisement.coupon_id)
    end
  end

  def update
    @cpd_advertisement = CpdAdvertisement.find(params[:id])
    if @cpd_advertisement.update_attributes(cpd_advertisement_params)
      if params[:cpd_advertisement][:ad_type] == '102'
        if @cpd_advertisement.coupon_id.present?
          flag = 1
          coupon = CouponFreeInfo.find(@cpd_advertisement.coupon_id)
        else
          flag = 2
          coupon = CouponFreeInfo.new
        end

        if params[:c_name].present?
          coupon.name = params[:c_name]
        end
        if params[:c_place].present?
          coupon.place = params[:c_place]
        end
        if params[:c_valid_start].present?
          coupon.valid_start = params[:c_valid_start]
        end
        if params[:c_valid_end].present?
          coupon.valid_end = params[:c_valid_end]
        end
        if params[:c_bar_code].present?
          coupon.bar_code = params[:c_bar_code]
        end
        if params[:c_image].present?
          coupon.image = params[:c_image]
        end
        if params[:c_information].present?
          coupon.information = params[:c_information]
        end

        if coupon.save
          if flag == 2
            @cpd_advertisement.update_attributes(:coupon_id => coupon.id)
          end
          redirect_to admin_cpd_advertisements_path, :notice => "Successfully created cpd advertisement."
        end
      else
        redirect_to admin_cpd_advertisements_path, :notice  => "Successfully updated cpd advertisement."
      end
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
    params.require(:cpd_advertisement).permit(:ad_type, :cli_id, :contract, :remain, :unit_price, :pay_type, :start_date, :end_date, :front_image, :back_image, :coupon_id, :priority, :ad_name)
  end
end
