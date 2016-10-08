class UsersController < ApplicationController
	def show
		@user = User.includes(:vote_options, :about_me).find_by_id(params[:id])
	end

	def edit
		@user = User.includes(:vote_options, :about_me).find_by_id(params[:id])
		@about = @user.about_me || @user.build_about_me
	end

	def update
		@user = User.includes(:vote_options, :about_me).find_by_id(params[:id])
		@about = @user.about_me || @user.create_about_me
		@about.update_attributes(bio: params[:bio])
		redirect_to user_path(current_user)
	end
end