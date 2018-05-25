require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:vasya)
	end

	test "post interface" do
		log_in_as(@user)
		get root_path
		assert_select 'ul.pagination'

		# Invalid information in form
		assert_no_difference 'Post.count' do
			post posts_path, post: { content: "" }
		end
		assert_select 'div#errors'

		# Valid information in form
		content = "This post really ties the room together"
		assert_difference 'Post.count', 1 do
			post posts_path, post: { content: content }
		end
		assert_redirected_to root_url
		follow_redirect!
		assert_match content, response.body


		# Delete Post
		assert_select 'a', text: 'delete'
		first_post = @user.posts.paginate(page: 1).first
		assert_difference 'Post.count', -1 do
			delete post_path(first_post)
		end

		# Go to another user's profile.
		get user_path(users(:petya))
		assert_select 'a', text: 'delete', count: 0
	end
end
