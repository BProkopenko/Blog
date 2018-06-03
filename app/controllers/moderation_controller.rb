class ModerationController < ApplicationController
	before_action :logged_in_user
	before_action :moderator
	include PostsHelper

	def new_posts
		@posts = Post.where("new_post= ?", true).paginate(page: params[:page])
	end

	def pending
		@posts = Post.where("pending= ?", true)
	end

	def update
		@post = Post.find(params[:id])
		@post_status = post_status
		if @post.update_attributes(update_params)
			flash[:success] = "Post status updated"
			redirect_to @post
		else
			render @post
		end
	end

	private

	def update_params
		if post_params["accepted"] == "accept"
			{accepted: true,
			 new_post: false,
			 pending: false,
			 rejected: false}
		elsif post_params["accepted"] == "decline"
			{accepted: false,
			 new_post: false,
			 pending: false,
			 rejected: true}
		end
	end

	def post_params
		params.require(:post).permit(:accepted)
	end

	def moderator
		redirect_to(root_url) unless current_user.moder?
	end
end
