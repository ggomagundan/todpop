class Admin::ScreenLocksController < ApplicationController
  before_action :set_admin_screen_lock, only: [:show, :edit, :update, :destroy]

  # GET /admin/screen_locks
  # GET /admin/screen_locks.json
  def index
    @lock_advertisements = LockAdvertisement.all
    @lock_cor_name = Client.all
  end

  # GET /admin/screen_locks/1
  # GET /admin/screen_locks/1.json
  def show
  end

  # GET /admin/screen_locks/new
  def new
    @admin_screen_lock = Admin::ScreenLock.new
  end

  # GET /admin/screen_locks/1/edit
  def edit
  end

  # POST /admin/screen_locks
  # POST /admin/screen_locks.json
  def create
    @admin_screen_lock = Admin::ScreenLock.new(admin_screen_lock_params)

    respond_to do |format|
      if @admin_screen_lock.save
        format.html { redirect_to @admin_screen_lock, notice: 'Screen lock was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_screen_lock }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_screen_lock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/screen_locks/1
  # PATCH/PUT /admin/screen_locks/1.json
  def update
    respond_to do |format|
      if @admin_screen_lock.update(admin_screen_lock_params)
        format.html { redirect_to @admin_screen_lock, notice: 'Screen lock was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_screen_lock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/screen_locks/1
  # DELETE /admin/screen_locks/1.json
  def destroy
    @admin_screen_lock.destroy
    respond_to do |format|
      format.html { redirect_to admin_screen_locks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_screen_lock
      @admin_screen_lock = Admin::ScreenLock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_screen_lock_params
      params[:admin_screen_lock]
    end
end
