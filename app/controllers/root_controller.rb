# Non-resource pages
class RootController < ApplicationController
  before_filter :authenticate_user!, only: [:make_pledge]

  def index
    @stories = Story.published.search_for(params[:q]).page(params[:page]).per(6);

    # apply filters
    if params[:type].present?
      value = Story::TYPE[params[:type].to_sym]
      if value.present?
        @stories = @stories.by_type(value) 
      else
        params[:type] = nil
      end
    end

    # apply sorting
    if params[:sort].present?
      case params[:sort]
        when 'views'
          @stories = @stories.sort_views
        else  # recent
          @stories = @stories.sort_recent
          params[:sort] = nil
      end
    else  # recent
      @stories = @stories.sort_recent
    end

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
    begin
      @pledge = Pledge.friendly.published.find(params[:id])
      impressionist(@pledge, :unique => [:session_hash]) # record the view coun
      @pledge = Pledge.friendly.published.with_translations(I18n.locale).find(params[:id])
      @pledges = Pledge.published.with_translations(I18n.locale).sorted.except_pledge(@pledge.id)
    rescue Exception
      redirect_to root_path
    end
  end

  def make_pledge
    # begin
      @pledge = Pledge.friendly.published.find(params[:id])
      @pledge.make_pledge(current_user)

      redirect_to pledge_path(@pledge, make_pledge: 'success')
    # rescue Exception
      # redirect_to root_path
    # end
  end

  def about
  end

end
