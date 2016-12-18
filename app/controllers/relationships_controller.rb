class RelationshipsController < ApplicationController
	def create
		@user = User.find(params[:followed_id])
  		if @relationship = Relationship.create(follower_id: current_user.id, followed_id: @user.id)
  			flash[:success] = @relationship.follow_who?
  			redirect_to root_path
		else
			flash[:warning] = 'Something went wrong!'
			redirect_to root_path
		end
	end

	def destroy
		@relationship = Relationship.find_by_id(params[:id])
		if @relationship.destroy
			flash[:success] = 'Relationship was destroyed :('
		else
			flash[:warning] = 'Error destroying this relationship...'
		end
		redirect_to polls_path
	end

	private
	def relationship_params
		params.permit(:follower_id, :followed_id)
	end
end