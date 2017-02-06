class CommentsController < ApplicationController
	def create_comment
		@comment = Comment.create(body: params[:body], 
			user_id: current_user.id, poll_id: params[:id])
		if @comment.save
			flash[:success] = "You just posted a comment"
			redirect_to polls_path
		else
			render new
		end
	end
end