class API::SearchAutoCompleteController < ApplicationController

	def index
		results = Elasticsearch::Model.search(params[:term], [Story, Tag, User])
		@stories = results.select { |result| result["_type"] == 'story' }
		@tags =    results.select { |result| result["_type"] == 'tag' }
		@users =   results.select { |result| result["_type"] == 'user' }
	end
end