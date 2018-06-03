class PagesController < ApplicationController
	def home
		@topics = Topic.all.map {|u| [u.theme, u.id]}
		if logged_in?
			@post = current_user.posts.build if logged_in?
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end
end
