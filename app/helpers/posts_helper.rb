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
			Post.all
		elsif current_user.moder?
			Post.where("new_post= ? OR pending= ?", true, true)
		else
			Post.where("accepted", true)
		end
	end
end
