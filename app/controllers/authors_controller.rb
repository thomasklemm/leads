class AuthorsController < ApplicationController
  before_action :load_author, only: [:show, :update]

  ##
  # Collection actions

  def search
    @query = params[:query] || ''
    @page = (params[:page] || 1).to_i

    @authors = []
    @authors = Twitter.user_search(@query, count: 20, page: @page) if @query.present?
  end

  ##
  # Member actions

  def show
  end

  def update
    @author.fetch_user
    @author.fetch_user_timeline
    redirect_to @author, notice: "#{ @author.at_screen_name } has been updated from Twitter."
  end

  private

  def load_author
    @author = Author.find_or_fetch_by_screen_name(params[:id])
    @author &&= @author.decorate
    return redirect_to root_path, alert: "@#{ params[:id] } could not be found on Twitter." unless @author.present?
  end
end
