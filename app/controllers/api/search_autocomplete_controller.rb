class API::SearchAutoCompleteController < ApplicationController

	def index
		results = Elasticsearch::Model.search(params[:term], [Storie, User, Tag])
		@stories = results.select { |result| result["_type"] == 'storie' }
		@tags =    results.select { |result| result["_type"] == 'tag' }
		@users =   results.select { |result| result["_type"] == 'user' }
	end
end