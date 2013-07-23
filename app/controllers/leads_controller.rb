class LeadsController < ApplicationController
  before_action :load_lead, only: [:show, :update, :refresh]

  ##
  # Collection actions

  # Search leads on Twitter
  def search
    @search = Search.new(params[:query], params[:page])
  end

  # Remember leads
  def remember
    load_lead
  end

  # Score leads
  def score
    @leads = Lead.having_score(score_params).by_joined_twitter_at.limit(100)
  end

  ##
  # Member actions

  def show
  end

  def update
    @lead.update(lead_params)
  end

  # Updates the lead and fetches the most recent 200 tweets
  # in the user timeline from Twitter
  def refresh
    @lead.fetch_user
    @lead.fetch_user_timeline

    redirect_to @lead,
      notice: "#{ @lead.at_screen_name } has been updated from Twitter."
  end

  private

  def load_lead
    @lead = Lead.find_or_fetch_by_screen_name(params[:id] || params[:screen_name])
    return redirect_to root_path, alert: "@#{ params[:id] } could not be found on Twitter." unless @lead.present?
  end

  def lead_params
    params.require(:lead).permit(:score)
  end

  def score_params
    params[:score] || :unscored
  end
end
