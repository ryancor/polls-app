require 'rails_helper'

RSpec.describe SearchDatum, :type => :model do
  it "is valid with valid attributes" do
    expect(SearchDatum.new(id: 1, value: 'football', user_id: 1, created_at: Time.current,
    	updated_at: Time.current)).to be_valid
  end

  it "is not valid without a title" do
  	expect(SearchDatum.new(id: 1, value: nil, user_id: 1, created_at: Time.current,
    	updated_at: Time.current)).to_not be_valid
  end

  it "exists when searching" do
  	search = SearchDatum.new(id: 1, value: 'ruby', user_id: 1, created_at: Time.current,
    	updated_at: Time.current)
  	expect(SearchDatum.search_exists(search.value)).to be(false)
  end
end