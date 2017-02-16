class Admin::HighlightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_highlight, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /admin/highlights
  # GET /admin/highlights.json
  def index
    @highlights = Highlight.all
  end

  # GET /admin/highlights/1
  # GET /admin/highlights/1.json
  def show
  end

  # GET /admin/highlights/new
  def new
    @highlight = Highlight.new
  end

  # GET /admin/highlights/1/edit
  def edit
  end

  # POST /admin/highlights
  # POST /admin/highlights.json
  def create
    @highlight = Highlight.new(highlight_params)

    respond_to do |format|
      if @highlight.save
        format.html { redirect_to [:admin,@highlight], notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.page_content', count: 1))}
        format.json { render :show, status: :created, location: @highlight }
      else
        format.html { render :new }
        format.json { render json: @highlight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/highlights/1
  # PATCH/PUT /admin/highlights/1.json
  def update
    respond_to do |format|
      if @highlight.update(highlight_params)
        format.html { redirect_to [:admin,@highlight], notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.page_content', count: 1))}
        format.json { render :show, status: :ok, location: @highlight }
      else
        format.html { render :edit }
        format.json { render json: @highlight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/highlights/1
  # DELETE /admin/highlights/1.json
  def destroy
    @highlight.destroy
    respond_to do |format|
      format.html { redirect_to admin_highlights_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.page_content', count: 1))}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_highlight
      @highlight = Highlight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def highlight_params
      permitted = Highlight.globalize_attribute_names + [:is_public, :image_en, :image_ka]
      params.require(:highlight).permit(*permitted)
    end
end
