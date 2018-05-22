require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
	  @user = User.new(name: "vasya", email: "vas@email.com",
	                   password: "vasvas", password_confirmation: "vasvas")
  end

	test "user should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.name = "   "
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = "   "
		assert_not @user.valid?
	end

	test "name should not be to long" do
		@user.name = "a" * 23
		assert_not @user.valid?
	end

	test "email should not be to long" do
		@user.email = "a" * 99
	end

	test "email validation should reject invalod address" do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
foo@bar_baz.com foo@bar+baz.com]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_addresses
			assert_not @user.valid?, "#{invalid_addresses.inspect} should be invalid"
		end
	end

	test "email should be unique" do
		user_duplicate = @user.dup
		user_duplicate.email = @user.email.upcase
		@user.save
		assert_not user_duplicate.valid?
	end

	test "password should have a minimum length" do
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end
end
