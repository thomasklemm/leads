class LeadsController < ApplicationController
  before_action :load_lead, only: [:show, :update, :refresh]

  ##
  # Collection actions

  def search
    @search = Search.new(params[:query], params[:page])
  end

  def score
    @leads = Lead.having_score(params[:score] || :unscored).order('statuses_count desc').limit(100)
    @leads &&= @leads.map { |lead| LeadDecorator.new(lead) }
  end

  ##
  # Member actions

  def show
  end

  def update
    @lead.update(lead_params)
  end

  # Updates the lead and the latest 200 tweets from Twitter
  def refresh
    @lead.fetch_user
    @lead.fetch_user_timeline
    redirect_to @lead, notice: "#{ @lead.at_screen_name } has been updated from Twitter."
  end

  private

  def load_lead
    @lead = Lead.find_or_fetch_by_screen_name(params[:id])
    @lead &&= LeadDecorator.new(@lead)
    return redirect_to root_path, alert: "@#{ params[:id] } could not be found on Twitter." unless @lead.present?
  end

  def lead_params
    params.require(:lead).permit(:score)
  end
end
