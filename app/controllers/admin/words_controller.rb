# -*- encoding : utf-8 -*-
class Admin::WordsController < Admin::ApplicationController
  def index
    @words = Word.page(params[:page]).per(10)
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
    
  #  @url = "http://todpop.herokuapp.com/picture/index.json?word=#{@word.name}"

   # @response = JSON.parse(open("http://todpop.herokuapp.com/picture/index.json?word=#{@word.name}").read)

  end

  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(word_params)
      if @word.image.present?
        @word.update_attributes(:picture => 1)
      end
      redirect_to admin_words_path
    else
      render :action => 'edit'
    end
  end

  def delete
    @word = Word.find(params[:id])
    @word.update_attributes(:picture => 0, :image => '')
    redirect_to admin_words_path
  end
  
  def destroy
    @word = Word.find(params[:id])
    
  end

  private
  def word_params
    params.require(:word).permit(:mean, :example_en, :example_ko, :phonetics, :picture, :image, :remote_image_url )
  end
end
