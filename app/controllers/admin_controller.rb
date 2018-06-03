class AdminController < ApplicationController
	before_action :logged_in_user
	before_action :admin_user

	def index
		@posts = posts_feed
	end

	def update #Assign moderator
		@user = User.find(params[:id])
		if @user.update_attributes(update_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			flash[:danger] = "Something wrong. \nPlease try again later."
			redirect_to @user
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		flash[:success] = "Post deleted"
		redirect_to(request.referrer || root_url)
	end

	private

	def update_params
		if user_params["moder"] == "1"
			{moder: true}
		else
			{moder: false}
		end
	end

	def user_params
		params.require(:user).permit(:moder)
	end
end
