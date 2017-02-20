class Admin::PledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pledge, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /admin/pledges
  # GET /admin/pledges.json
  def index
    @pledges = Pledge.sorted
  end

  # GET /admin/pledges/1
  # GET /admin/pledges/1.json
  def show
  end

  # GET /admin/pledges/new
  def new
    @pledge = Pledge.new
  end

  # GET /admin/pledges/1/edit
  def edit
  end

  # POST /admin/pledges
  # POST /admin/pledges.json
  def create
    @pledge = Pledge.new(pledge_params)

    respond_to do |format|
      if @pledge.save
        format.html { redirect_to [:admin, @pledge], notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.pledge', count: 1))}
      else
        format.html { render :new }
        format.json { render json: @pledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pledges/1
  # PATCH/PUT /admin/pledges/1.json
  def update
    respond_to do |format|
      if @pledge.update(pledge_params)
        format.html { redirect_to [:admin, @pledge], notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.pledge', count: 1))}
      else
        format.html { render :edit }
        format.json { render json: @pledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pledges/1
  # DELETE /admin/pledges/1.json
  def destroy
    @pledge.destroy
    respond_to do |format|
      format.html { redirect_to admin_pledges_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.pledge', count: 1))}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pledge
      @pledge = Pledge.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pledge_params
      permitted = Pledge.globalize_attribute_names + [:is_public, :image]
      params.require(:pledge).permit(*permitted)
    end
end
