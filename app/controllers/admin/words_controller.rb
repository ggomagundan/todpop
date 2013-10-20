# -*- encoding : utf-8 -*-
class Admin::WordsController < Admin::ApplicationController
  def index
    @page = params[:page] ? params[:page] : 1
    @align = params[:align] == '1' ? '1' : '0'
    if params[:search].present?
      q = "%#{params[:search]}%"
      @words = Word.where("name LIKE ? OR mean LIKE ?", q, q).page(params[:page]).per(10)
    else
      @words = !params[:align].present? || params[:align] == '0' ? Word.page(params[:page]).per(10) : 
        (params[:align] == '1' ? Word.where(:picture => 0).page(params[:page]).per(10) : Word.where(:confirm => 1).page(params[:page]).per(10) )
    end
    @picture_cnt = Word.where(:picture =>0).count
    @word_cnt = Word.count
    @confirm_cnt = Word.where(:confirm => 1).count
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(params[:word])
    if @word.save
      redirect_to [:admin, @word], :notice => "Successfully created word."
    else
      render :action => 'new'
    end
  end

  def edit
    @word = Word.find(params[:id])
    @page = params[:before_page]
    @isalign = params[:is_align]
    @picture_cnt = Word.where(:picture =>0).count
    @word_cnt = Word.count
  #  @url = "http://todpop.herokuapp.com/picture/index.json?word=#{@word.name}"

   # @response = JSON.parse(open("http://todpop.herokuapp.com/picture/index.json?word=#{@word.name}").read)

  end

  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(word_params)
      if @word.image.present?
        @word.update_attributes(:picture => 1)
      end
      redirect_to admin_words_path(:page => params[:before_page], :align => params[:before_align])
    else
      render :action => 'edit'
    end
  end

  def delete
    @word = Word.find(params[:id])
    @word.update_attributes(:picture => 0, :image => '')
    redirect_to admin_words_path(:page => params[:before_page], :align => params[:is_align])
  end
  
  def confirm
    if request.get?
      @confirm = true
      @word = Word.where('picture = ? and confirm = ?', 1, 0).order("RAND()").first
      @picture_cnt = Word.where(:picture => 1).count
      @confirm_cnt = Word.where(:confirm => 1).count
      render :action => 'edit'
    else
      @word = Word.find(params[:id])
      @word.update_attributes(:confirm => 1)
      if @word.update_attributes(word_params)
        redirect_to admin_words_dummy_confirm_path
      else
        render :file => "#{Rails.root}/public/500"
      end
    end
  end

  def destroy
    @word = Word.find(params[:id])
    
  end

  def get_img_url
    @status = true
    @msg = ''
    query = URI::encode(params[:word])
    start = params[:start]
    @data_url = []
    url = "https://www.google.co.kr/search?q=#{query}&newwindow=1&as_st=y&hl=ko&tbs=sur:fc&biw=1051&bih=573&sei=QAdcUujIPOWXiQecuICwAg&tbm=isch&ijn=1&ei=QAdcUujIPOWXiQecuICwAg&start=#{start}&csl=1"
    doc = Nokogiri::HTML(open(url))
    html = doc.xpath("//div[contains(@class,'rg_di')]")
    @length = html.length

    for tmp in html
      img_url = CGI::parse(URI::parse(tmp.children.first.attributes['href'].value).query)
      show_src = tmp.children.first.children.first.attributes['src'].value
      tmp_data = {'show' => show_src, 'real_url' => img_url['imgurl'][0]}
      @data_url.push(tmp_data)
    end
  end

  private
  def word_params
    params.require(:word).permit(:mean, :example_en, :example_ko, :phonetics, :picture, :image, :remote_image_url )
  end
end
