require 'spec_helper'

describe 'Twitter accounts' do
  it 'lists Twitter accounts' do
    visit root_path
    click_on 'Twitter accounts'
    expect(current_path).to eq(twitter_accounts_path)

    click_on 'Connect a Twitter account'
    expect(current_path).to eq(twitter_accounts_path)
    expect(page).to have_content("Twitter account has been connected.")
  end
end
