class TopicsController < ApplicationController
	before_action :logged_in_user, only: [:index, :show]
	before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

	def index
		@topics = Topic.all.paginate(page: params[:page])
	end

	def show
		@topic = Topic.find(params[:id])

		@posts = Post.where(topic_id: params[:id]).paginate(page: params[:page])
	end

	def new
		@topic = Topic.new
	end

	def create
		@topic = current_user.topics.build(topic_params)
		if @topic.save
			flash[:success] = "Topic created!"
			redirect_to request.referrer || root_url
		else
			render new
		end
	end

	def edit
		@topic = Topic.find(params[:id])
	end

	def update
		@topic = Topic.find(params[:id])
		if @topic.update_attributes(topic_params)
			flash.now[:success] = "Topic updated"
			render 'edit'
		else
			render 'edit'
		end
	end

	def destroy
		@topic.destroy
		flash[:success] = "Topic deleted"
		redirect_to request.referrer || root_url
	end

	private

	def topic_params
		params.require(:topic).permit(:theme, :description)
	end

end
