require 'spec_helper'

describe 'Author' do
  it "fetches the author from Twitter" do
    # HTTP Basic authorization
    page.driver.browser.basic_authorize('tweetbox', 'dash')

    # First visit triggers fetch from Twitter
    VCR.use_cassette('users/simyo') do
      visit '/authors/simyo'
    end

    expect(current_path).to eq('/authors/simyo')
    expect(page).to have_content("@simyo")
    expect(page).to have_content("simyo Deutschland")

    # No HTTP request on second visit
    visit '/authors/simyo'
    expect(current_path).to eq('/authors/simyo')

    # Click on update retrieves the latest 200 tweets
    # NOTE: This creates 200 tweets in the database
    VCR.use_cassette('user_timelines/simyo') do
      click_on 'Update', match: :first
    end

    expect(page).to have_content("@simyo has been updated from Twitter.")
    expect(page).to have_content("200 tweets being analyzed")
  end
end
