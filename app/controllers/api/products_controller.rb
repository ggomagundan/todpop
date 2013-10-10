# -*- encoding : utf-8 -*-
class Api::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end


  def get_product_info
    @status = true
    @msg  = ""
    
    if !params[:product_id].present?
      @status = false
      @msg = "not exist product_id parameter"
    end
  
    if @status == true
      @info = Product.find(params[:product_id])
    end

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to [:api, @product], :notice => "Successfully created product."
    else
      render :action => 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to [:api, @product], :notice  => "Successfully updated product."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to api_products_url, :notice => "Successfully destroyed product."
  end
end
