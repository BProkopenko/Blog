class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
	before_action :correct_user || :admin_user, only: [:destroy, :edit, :update]

	include PostsHelper

	def show
		@post = Post.find(params[:id])
		@topic = Topic.find(@post.topic_id)
		@comments = @post.comments.paginate(page: params[:page])
		@comment = Comment.new
		@post_status = post_status
	end

	def show_comments
		@comments = @post.comments
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post created!"
			redirect_to root_url
		else
			@feed_items = []
			redirect_to root_url
		end
	end

	def edit
		@post = Post.find(params[:id])
		@topics = Topic.all.map {|u| [u.theme, u.id]}
	end

	def update
		@post = Post.find(params[:id])
		if @post.accepted? || @post.rejected?
			update_params = post_params.merge!({
					                                   new_post: false,
					                                   accepted: false,
					                                   pending: true,
					                                   rejected: false
			                                   })
			if @post.update_attributes(update_params)
				flash[:success] = "Post updated"
				redirect_to @post
			else
				render edit
			end
		else
			if @post.update_attributes(post_params)
				flash[:success] = "Post updated"
				redirect_to @post
			else
				render "edit"
			end
		end
	end

	def destroy
		@post.destroy
		flash[:success] = "Post deleted"
		redirect_to(request.referrer || root_url)
	end

	def create_comment
		@post = Post.find(params[:id])
		@comment = @post.comments.create(comment_params.merge!({user_id: current_user.id}))
		if @comment.save
			flash[:success] = "Comment saved"
			redirect_to @post
		else
			redirect_to @post
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

	def post_params
		params.require(:post).permit(:content, :picture, :title, :topic_id)
	end

	def correct_user
		@post = current_user.posts.find_by(id: params[:id])
		redirect_to root_url if @post.nil?
	end
end
