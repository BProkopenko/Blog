module PostsHelper
	def post_status
		if @post.new_post? && !@post.pending? && !@post.accepted && !@post.rejected?
			"New"
		elsif !@post.new_post? && @post.pending? && !@post.accepted? && !@post.rejected?
			"Pending"
		elsif !@post.new_post? && !@post.pending? && @post.accepted? && !@post.rejected?
			"Accepted"
		elsif !@post.new_post? && !@post.pending? && !@post.accepted? && @post.rejected?
			"Declined"
		else
			"Undefined post status"
		end
	end

	def posts_feed
		if current_user.admin?
			Post.all.paginate(page: params[:page])
		elsif current_user.moder?
			Post.where("new_post= ? OR pending= ?", true, true).paginate(page: params[:page])
		else
			Post.where("accepted", true).paginate(page: params[:page])
		end
	end
end
