class UsersController < ApplicationController
	def show
		@user = User.includes(:vote_options, :about_me).find_by_slug(params[:slug])
	end

	def edit
		@user = User.includes(:vote_options, :about_me).find_by_slug(params[:slug])
		@about = @user.about_me || @user.build_about_me
		if @user != current_user
			if current_user
				redirect_to user_path(current_user)
			else
				redirect_to polls_path
			end
		end
	end

	def manage
		@user = User.includes(:polls, :about_me).find_by_slug(params[:slug])
		if @user != current_user
			if current_user
				redirect_to user_path(current_user)
			else
				redirect_to polls_path
			end
		end
	end

	def update
		@user = User.includes(:vote_options, :about_me).find_by_slug(params[:slug])
		@about = @user.about_me || @user.create_about_me
		@about.update_attributes(bio: params[:bio])
		@about.update_count += 1 
		@about.save
		redirect_to user_path(current_user)
	end

	private
	def user_params
   		params.require(:user).permit(:slug)
 	end
end