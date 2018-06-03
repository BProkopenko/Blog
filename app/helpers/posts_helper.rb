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
end
