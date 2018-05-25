require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
	def setup
		ActionMailer::Base.deliveries.clear
		@user = users(:vasya)
	end

	test "password resets" do
		get new_password_reset_path
		assert_template 'password_resets/new'

# POST Invalid email
		post password_resets_path, password_reset: {email: ""}
		assert_not flash.empty?
		assert_template 'password_resets/new'

# POST Valid email
		post password_resets_path, password_reset: {email: @user.email}
		assert_not_equal @user.reset_digest, @user.reload.reset_digest
		assert_equal 1, ActionMailer::Base.deliveries.size
		assert_not flash.empty?
		assert_redirected_to root_url

# Password reset form
		user = assigns(:user)

# Get Invalid email
		get edit_password_reset_path(user.reset_token, email: "")
		assert_redirected_to root_url

# Account is not activate
		user.toggle!(:activated)
		get edit_password_reset_path(user.reset_token, email: user.email)
		assert_redirected_to root_url
		user.toggle!(:activated)

# Get valid email & INVALID token
		get edit_password_reset_path('wrong token', email: user.email)
		assert_redirected_to root_url

# Get valid email & VALID token
		get edit_password_reset_path(user.reset_token, email: user.email)
		assert_template 'password_resets/edit'
		assert_select "input[name=email][type=hidden][value=?]", user.email

# Invalif password and confirmation
		patch password_reset_path(user.reset_token),
		      email: user.email,
		      user: {password: "foobaz",
		             password_confirmation: "barquux"}
		assert_select 'div#errors'

# Empty password
		patch password_reset_path(user.reset_token),
		      email: user.email,
		      user: {password: " ",
		             password_confirmation: "foobar"}
		assert_not flash.empty?
		assert_template 'password_resets/edit'

# VALID password & confirmation
		patch password_reset_path(user.reset_token),
		      email: user.email,
		      user: {password: "foobaz",
		             password_confirmation: "foobaz"}
		assert is_logged_in?
		assert_not flash.empty?
		assert_redirected_to user
	end
end
