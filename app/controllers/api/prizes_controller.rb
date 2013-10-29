# -*- encoding : utf-8 -*-
class Api::PrizesController < ApplicationController
  def index
    @prizes = Prize.all
  end

  def show
    @prize = Prize.find(params[:id])
  end


  def get_prize_info
    @status = true
    @msg  = ""
    
    if !params[:prize_id].present?
      @status = false
      @msg = "not exist prize_id parameter"
    end
  
    if @status == true
      @info = Prize.find_by_id(params[:prize_id])
    end

  end

  def new
    @prize = Prize.new
  end

  def create
    @prize = Prize.new(params[:prize])
    if @prize.save
      redirect_to [:api, @prize], :notice => "Successfully created prize."
    else
      render :action => 'new'
    end
  end

  def edit
    @prize = Prize.find(params[:id])
  end

  def update
    @prize = Prize.find(params[:id])
    if @prize.update_attributes(params[:prize])
      redirect_to [:api, @prize], :notice  => "Successfully updated prize."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @prize = Prize.find(params[:id])
    @prize.destroy
    redirect_to api_prizes_url, :notice => "Successfully destroyed prize."
  end
end
