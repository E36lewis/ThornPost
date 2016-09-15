class RecommendedStoriesController < ApplicationController
	def index
		@user = User.find(params[:user_id])
		@recommended_stories = @user.liked_stories.published.paginate(page: params[:page])
	end
end
