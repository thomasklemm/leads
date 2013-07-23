require 'spec_helper'

describe "Search for Twitter users" do
  it "finds Twitter users" do
    # HTTP Basic authorization
    page.driver.browser.basic_authorize('tweetbox', 'dash')

    # User search
    VCR.use_cassette('user_searches/customer_care') do
      visit search_leads_path

      # Search
      fill_in 'query', with: 'Customer Care'
      click_on 'Search'

      # Pagination
      click_on 'Next page'
      click_on 'Previous page'
    end
  end
end
