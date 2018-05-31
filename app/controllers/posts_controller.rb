class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
	before_action :correct_user, only: [:destroy, :delete_comment]
	before_action :correct_commenter, only: [:delete_comment]

	def show
		@post = Post.find(params[:id])
	  @topic = Topic.find(@post.topic_id)
		@comments = @post.comments
		@comment = Comment.new
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
			render 'pages/home'
		end
	end

	def edit
		@post = Post.find(params[:id])
		@topics = Topic.all.map{|u| [ u.theme, u.id ] }
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			flash[:success] = "Post updated"
			redirect_to show
		else
			render edit
		end
	end

	def destroy
		@post.destroy
		flash[:success] = "Post deleted"
		redirect_to root_url
	end


	def create_comment
		@post = Post.find(params[:id])
		params = comment_params
		params["user_id"] = current_user.id
		@comment = @post.comments.create(params)
		if @comment.save
			flash[:success] = "Comment saved"
			redirect_to @post
		else
			redirect_to root_url
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
