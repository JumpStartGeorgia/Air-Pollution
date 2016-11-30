# Non-resource pages
class RootController < ApplicationController

  def index
    @stories = Story.published.sorted.page(params[:page])
    @show_page_title = false

  end

  def story
    begin
      @story = Story.friendly.with_translations(I18n.locale).find(params[:id])
    rescue Exception
      redirect_to root_path
    end

  end

  def about
  end

end
