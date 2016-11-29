# Non-resource pages
class RootController < ApplicationController
  def index
    @stories = Story.published.sorted.page(params[:page])
    @show_page_title = false

  end

  def about
  end
end
