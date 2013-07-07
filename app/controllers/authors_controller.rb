class AuthorsController < ApplicationController
  before_action :load_author, only: [:show, :update]

  def show
  end

  def update
    @author.fetch_user_timeline
    redirect_to @author, notice: "#{ @author.at_screen_name } has been updated from Twitter."
  end

  private

  def load_author
    @author = Author.find_by!(screen_name: params[:id]).decorate
  rescue ActiveRecord::RecordNotFound
    @author = fetch_author(params[:id])
  end

  # Fetches the author from Twitter
  # Returns the author
  def fetch_author(screen_name)
    logger.info "Fetching @#{ screen_name } from Twitter."
    twitter_user = Twitter.user(screen_name)
    Author.from_twitter(twitter_user)
  rescue Twitter::Error::NotFound
    redirect_to root_path, alert: "@#{ screen_name } could not be found on Twitter."
  end
end

  # before_action :load_author, only: [:show, :fetch_user_timeline, :mark_as_lead]

  # def index
  #   @q = Author.search(params[:q])
  #   @authors = @q.result.page(params[:page])
  #   @q.build_condition if @q.conditions.empty?
  #   @q.build_sort if @q.sorts.empty?

  #   @authors ||= Author.order(statuses_count: :desc).where(lang: 'de').page(params[:page])
  # end

  # def leads
  #   index

  #   @authors = Author.where(lead: true)
  #   render :index
  # end

  # def search
  #   index
  #   render :index
  # end


  # def fetch_user_timeline
  #   statuses = Twitter.user_timeline(@author.screen_name, count: 200)
  #   statuses.each { |status| Tweet.from_twitter(status) }
  #   redirect_to @author,
  #     notice: "The most recent statuses from the author's user timeline have been retrieved."
  # end

  # def mark_as_lead
  #   @author.mark_as_lead!
  #   redirect_to :back,
  #     notice: "#{ @author.at_screen_name } has been marked as LEAD."
  # end
