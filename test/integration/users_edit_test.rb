require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:vasya)
	end

	test "unsuccessfull edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: {
				name: "gogi",
				email: "foo@invalid",
				password: "wew",
				password_confirmation: "ioi"}
		assert_template 'users/edit'
	end

	test "succesfull edit with friendly forwarding" do
		get edit_user_path(@user)
		log_in_as(@user)
		assert_redirected_to edit_user_path(@user)
		name = "bred"
		email = "bred@breder.com"
		patch user_path(@user), user: {name: name,
		                               email: email,
		                               password: "",
		                               password_confirmation: ""}
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal @user.name, name
		assert_equal @user.email, email
	end
end
