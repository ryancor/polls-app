require 'rails_helper'
require 'spec_helper'

describe 'Go to products and assert' do
  before(:all) do
    setup_selenium
  end

  before(:each) do
    visit '/polls'
  end

  it 'should assert the homepage as logged out user' do
    expect(current_path).to eq '/polls'
    find('h1', text: ' Most Recent Polls!', exact: false)
    find(:xpath, "//a[@href='/search']").click
    expect(current_path).to eq '/search'
    find('.navbar-brand', text: 'Polls').click
    expect(current_path).to eq '/'
    within('.well', match: :first) do
      page.should have_selector('h2', text: 'How long does it take')
      page.should have_selector('h5', text: 'Total Votes: ')
      page.should have_selector('p', text: 'Posted: 10/10/2016')
    end 
  end
end
