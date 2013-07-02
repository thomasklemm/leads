class AuthorsController < ApplicationController
  before_action :load_author, only: [:show, :fetch_user_timeline, :mark_as_lead]
  def index
    @authors = Author.order(statuses_count: :desc).where(lang: 'de').limit(100)
  end

  def leads
    @authors = Author.where(lead: true)
    render :index
  end

  def show
  end

  def fetch_user_timeline
    statuses = Twitter.user_timeline(@author.screen_name, count: 200)
    statuses.each { |status| Tweet.from_twitter(status) }
    redirect_to @author,
      notice: "The most recent statuses from the author's user timeline have been retrieved."
  end

  def mark_as_lead
    @author.mark_as_lead!
    redirect_to :back,
      notice: "#{ @author.at_screen_name } has been marked as LEAD."
  end

  private

  def load_author
    @author = Author.find_by(screen_name: params[:id])
  end
end
