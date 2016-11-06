class SearchController < ApplicationController
	def search
		if params[:query].nil?
  			@polls = []
  			@vote_options = []
    	else
    		@searches = SearchDatum.common_searches?
  			@polls = Poll.search(params[:query]).order(created_at: :desc)
  			@vote_options = VoteOption.search(params[:query]).order(created_at: :desc)
			if current_user && params[:query]
				SearchDatum.create(value: params[:query], user_id: current_user.id)
			else
				SearchDatum.create(value: params[:query])
			end
  		end
	end
end
