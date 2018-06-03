class CommentsController < ApplicationController
	before_action :logged_in_user
	before_action :correct_commenter, only: :destroy

	def destroy
		@comment.destroy
		flash[:success] = "Comment deleted"
		redirect_to request.referrer || root_url
	end

	private

	def correct_commenter
		@comment = current_user.comments.find_by(id: params[:id])
		if @comment.nil?
			flash[:danger] = "It`s not your comment!"
			redirect_to request.referrer || root_url
		end
	end
end
