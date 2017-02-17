class Admin::StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /admin/stories
  # GET /admin/stories.json
  def index
    @stories = Story.sort_recent
  end

  # GET /admin/stories/1
  # GET /admin/stories/1.json
  def show
  end

  # GET /admin/stories/new
  def new
    @story = Story.new
  end

  # GET /admin/stories/1/edit
  def edit
  end

  # POST /admin/stories
  # POST /admin/stories.json
  def create
    @story = Story.new(story_params)

    respond_to do |format|
      if @story.save
        format.html { redirect_to [:admin, @story], notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.story', count: 1))}
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/stories/1
  # PATCH/PUT /admin/stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to [:admin, @story], notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.story', count: 1))}
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/stories/1
  # DELETE /admin/stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to admin_stories_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.story', count: 1))}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.friendly.find(params[:id])

      @story_types = []
      Story::TYPE.each do |key, value|
        @story_types << [I18n.t("shared.story_types.#{key}"), value]
      end

      # indicate which stories use image and which use embed code
      gon.image_stories = %w(1 6 7)
      gon.embed_stories = %w(2 3 4 5)

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      permitted = Story.globalize_attribute_names + [:story_type, :is_public, :image_en, :image_ka, :thumbnail_en, :thumbnail_ka]
      params.require(:story).permit(*permitted)
    end
end
