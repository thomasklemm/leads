require 'spec_helper'

describe 'Lead' do
  it "fetches the lead from Twitter" do
    # HTTP Basic authorization
    page.driver.browser.basic_authorize('tweetbox', 'dash')

    # First visit triggers fetch from Twitter
    VCR.use_cassette('users/simyo') do
      visit '/leads/simyo'
    end

    expect(current_path).to eq('/leads/simyo')
    expect(page).to have_content("@simyo")
    expect(page).to have_content("simyo Deutschland")

    # No HTTP request on second visit
    visit '/leads/simyo'
    expect(current_path).to eq('/leads/simyo')

    # Click on update retrieves the latest 200 tweets
    # NOTE: This creates 200 tweets in the database
    VCR.use_cassette('user_timelines/simyo') do
      click_on 'Refresh'
    end

    expect(page).to have_content("@simyo has been updated from Twitter.")
    expect(page).to have_content("from 5 tweets")
  end
end
