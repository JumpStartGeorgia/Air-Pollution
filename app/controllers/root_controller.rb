# Non-resource pages
class RootController < ApplicationController

  def index
    @stories = Story.published.sorted.page(params[:page])
    @show_page_title = false
    @highlights = Highlight.published.sorted
  end

  def story
    begin
      @story = Story.friendly.published.find(params[:id])
      impressionist(@story, :unique => [:session_hash]) # record the view coun
      @story = Story.friendly.published.with_datasources.with_translations(I18n.locale).find(params[:id])
    rescue Exception
      redirect_to root_path
    end
  end

  def pledge
    # begin
      @pledge = Pledge.friendly.published.find(params[:id])
      impressionist(@pledge, :unique => [:session_hash]) # record the view coun
      @pledge = Pledge.friendly.published.with_translations(I18n.locale).find(params[:id])
      @pledges = Pledge.published.with_translations(I18n.locale).sorted.except_pledge(@pledge.id)
    # rescue Exception
      # redirect_to root_path
      # end
  end

  def about
  end

end
