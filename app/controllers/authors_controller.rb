class AuthorsController < ApplicationController
  before_action :load_author, only: [:show, :update]

  ##
  # Collection actions

  def search
    @search = Search.new(params[:query], params[:page])
  end

  def score
    @authors = Author.having_score(score_params)
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

  def score_params
    params[:score].try(:to_sym) || :unscored
  end
end
