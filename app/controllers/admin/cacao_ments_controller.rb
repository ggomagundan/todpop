class Admin::CacaoMentsController < Admin::ApplicationController
  def index
    @cacao_ments = CacaoMent.all
  end

  def new
    @cacao_ment = CacaoMent.new
  end

  def create
    @cacao_ment = CacaoMent.new(ment_params)
    if @cacao_ment.save
      redirect_to admin_cacao_ments_path, :notice => "Successfully created cacao ment."
    else
      render :action => 'new'
    end
  end

  def edit
    @cacao_ment = CacaoMent.find(params[:id])
  end

  def update
    @cacao_ment = CacaoMent.find(params[:id])
    if @cacao_ment.update_attributes(ment_params)
      redirect_to admin_cacao_ments_path, :notice  => "Successfully updated cacao ment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @cacao_ment = CacaoMent.find(params[:id])
    @cacao_ment.destroy
    redirect_to admin_cacao_ments_url, :notice => "Successfully destroyed cacao ment."
  end

  private
  def ment_params
      params.require(:cacao_ment).permit(:ment)
  end

end
