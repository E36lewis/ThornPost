class API::TagFollowersController < ApplicationController

	def index
		tag = Tag.find(params[:tag_id])
		@follwers = tag.follwers
	end
end