class ActivityController < ApplicationController
	def activity
		@user = User.all.order(created_at: :desc)
	end
end