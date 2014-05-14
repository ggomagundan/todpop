class Admin::CpxAdvertisementsController < Admin::ApplicationController
  def index
    if !params[:type].present?
      @cpx_advertisements = CpxAdvertisement.all.order("id desc")
      @r=1
    elsif params[:type]=="1"
      @cpx_advertisements = CpxAdvertisement.where('remain > 0 and start_date <= ? and end_date >= ? and priority > 0 and priority < 6', Date.today, Date.today).order("id desc")
      @r=2
    elsif params[:type]=="0"
      @cpx_advertisements = CpxAdvertisement.where('remain < 0 or start_date > ? or end_date < ? or priority = 0 or priority > 5', Date.today, Date.today).order("id desc")
      @r=3
    end
    @cpx_cor_name = Client.all
  end

  def show
    @cpx_advertisement = CpxAdvertisement.find(params[:id])
  end

  def new
    @cpx_advertisement = CpxAdvertisement.new
    @n_question_arr = []
    @n_answer_arr = []
    @client_arr = []
    client_all = Client.all
    for i in 1..client_all.size
      client_str = "Cor Name : " + client_all[i-1].cor_name.to_s + " | Name : " + client_all[i-1].name.to_s
      @client_arr.push([].push(client_str, client_all[i-1].id))
    end
    for i in 0..15
      @n_question_arr.push([].push("#{i}",i))
    end
    for i in 0..5
      @n_answer_arr.push([].push("#{i}",i))
    end
  end

  def create
    @cpx_advertisement = CpxAdvertisement.new(cpx_params)

    if @cpx_advertisement.save
      flag = true
      if params[:cpx_advertisement][:n_question] != '0'
        img_idx =0
        survey_content = SurveyContent.new
        survey_content.ad_id = @cpx_advertisement.id
        survey_content.q_no = 0
        survey_content.q_type = 0
        survey_content.q_text = params[:spec_text]
        if survey_content.save
          params[:q_no].each_with_index do |q_no, i|
            survey_content = SurveyContent.new
            survey_content.ad_id = @cpx_advertisement.id
            survey_content.q_no = params[:q_no][i]
            survey_content.q_type = params[:q_type][i]
            survey_content.q_text = params[:q_text][i]
            if params[:q_type][i] == '2' || params[:q_type][i] == '4'
              survey_content.q_image = params[:q_image][img_idx]
              img_idx += 1
            end
            survey_content.n_answer = params[:n_answer][i]
            survey_content.a1 = params[:a1][i]
            survey_content.a2 = params[:a2][i]
            survey_content.a3 = params[:a3][i]
            survey_content.a4 = params[:a4][i]
            survey_content.a5 = params[:a5][i]
            if survey_content.save == false
              flag = false
              break;
            end
          end
        else
          flag = false
        end
      end
      if flag == false
        render :action => 'new'
      else
        redirect_to admin_cpx_advertisements_path, :notice => "Successfully created cpx advertisement."
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @cpx_advertisement = CpxAdvertisement.find(params[:id])
    @n_question_arr = []
    @n_answer_arr = []
    @client_arr = []
    client_all = Client.all
    for i in 1..client_all.size
      client_str = "Cor Name : " + client_all[i-1].cor_name.to_s + " | Name : " + client_all[i-1].name.to_s
      @client_arr.push([].push(client_str, i))
    end
    for i in 0..15
      @n_question_arr.push([].push("#{i}",i))
    end
    for i in 0..5
      @n_answer_arr.push([].push("#{i}",i))
    end

    if @cpx_advertisement.n_question != 0
      @questions = SurveyContent.where(:ad_id => @cpx_advertisement.id).order("q_no ASC")
    end
  end

  def update
    @cpx_advertisement = CpxAdvertisement.find(params[:id])
    if @cpx_advertisement.update_attributes(cpx_params)
      if params[:cpx_advertisement][:n_question] != '0'
        img_idx =0
        survey_content = SurveyContent.find(params[:spec_cid])
        survey_content.update_attributes(:q_text => params[:spec_text])
        
        params[:q_no].each_with_index do |q_no, i|
          if params[:cid][i].present?
            survey_content = SurveyContent.find(params[:cid][i])   
            survey_content.update_attributes(
              :q_no => params[:q_no][i],
              :q_type => params[:q_type][i],
              :q_text => params[:q_text][i],
              :n_answer => params[:n_answer][i],
              :a1 => params[:a1][i],
              :a2 => params[:a2][i],
              :a3 => params[:a3][i],
              :a4 => params[:a4][i],
              :a5 => params[:a5][i]
            )
            
            if params[:q_type][i] == '2' || params[:q_type][i] == '4'
              if params[:origin_type][i] == '1' || params[:origin_type][i] == '3'
                survey_content.update_attributes(:q_image => params[:q_image][img_idx])
                img_idx += 1
              else
                if params[:q_delete][i] == '1'
                  survey_content.update_attributes(:q_image => params[:q_image][img_idx])
                  img_idx += 1
                end
              end
            else
              survey_content.remove_q_image!
              survey_content.save
            end
          else
            survey_content = SurveyContent.new
            survey_content.ad_id = @cpx_advertisement.id
            survey_content.q_no = params[:q_no][i]
            survey_content.q_type = params[:q_type][i]
            survey_content.q_text = params[:q_text][i]
            if params[:q_type][i] == '2' || params[:q_type][i] == '4'
              survey_content.q_image = params[:q_image][img_idx]
              img_idx += 1
            end
            survey_content.n_answer = params[:n_answer][i]
            survey_content.a1 = params[:a1][i]
            survey_content.a2 = params[:a2][i]
            survey_content.a3 = params[:a3][i]
            survey_content.a4 = params[:a4][i]
            survey_content.a5 = params[:a5][i]
            survey_content.save
          end
        end

        if params[:q_no].size < params[:cid].size
          for i in params[:q_no].size..params[:cid].size-1
            survey_content = SurveyContent.find(params[:cid][i])
            survey_content.destroy
          end
        end
      end
      redirect_to admin_cpx_advertisements_path, :notice => "Successfully updated cpx advertisement."
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
    params.require(:cpx_advertisement).permit(:ad_name, :cli_id, :ad_type, :start_date, :end_date, :contract, :remain, :basic_show_price, :pay_type, :ad_image, :ad_text, :target_url, :package_name, :confirm_url, :reward, :point, :n_question, :priority)
  end
end
