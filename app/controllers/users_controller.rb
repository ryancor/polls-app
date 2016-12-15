class UsersController < ApplicationController
	def show
		@user = User.includes(:vote_options, :about_me).find_by_slug(params[:slug]) || 
		@user = !params[:slug].nil? ? User.includes(:vote_options, :about_me).find(params[:slug]) : current_user
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

	def followers
		@user = User.find_by_slug(params[:slug])
	end

	def following
		@user = User.find_by_slug(params[:slug])
	end

	def update
		@user = User.includes(:vote_options, :about_me).find_by_slug(params[:slug])
		@about = @user.about_me || @user.create_about_me
		if AboutMe.check_bad_words.index{ |x| params[:bio].include?(x) }.present?
			new_sentence = params[:bio].split.delete_if { |x| AboutMe.check_bad_words.include?(x) }.join(' ')
			@about.update_attributes(bio: new_sentence, age: params[:age])
			flash[:warning] = "Can't use profanity in your bio. Please try again."
		elsif AboutMe.check_bad_words.index{ |x| params[:bio].include?(x) }.nil?
			@about.update_attributes(bio: params[:bio], age: params[:age])
		else
			flash[:warning] = "Can't update bio right now."
		end
		unless params[:avatar].blank?
			@user.update_attributes(is_public: params[:is_public], 
				avatar_file_name: params[:avatar])
			File.open(Rails.root.join('app/assets/images', 'users', params[:avatar]), 'wb') do |f|
		  		f.write(params[:avatar])
			end
		end
		@about.update_count += 1 
		@about.save
		redirect_to user_path(current_user)
	end

	private
	def user_params
   		params.require(:user).permit(:slug)
 	end
end