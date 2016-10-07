class UsersController < ApplicationController
	def show
		@user = User.includes(:vote_options, :about_me).find_by_id(params[:id])
	end

	def edit
		@user = User.includes(:vote_options, :about_me).find_by_id(params[:id])
		@about = @user.about_me || @user.build_about_me
	end
end