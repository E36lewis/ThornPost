class SearchController < ApplicationController
  before_action :beautify_url
  layout "simple"

  def show
    @story_records = Story.search(query_term).paginate(page: params[:page]).records
    @stories = @story_records.to_a.select { |story| story.published? }
    @users = User.search(query_term).records.to_a
    @tags = Tag.search(query_term).records
  end

  def users
    @users = User.search(query_term).records.to_a
  end

  private

    def beautify_url
      if params[:search].present?
        case params[:action]
        when "show"
          redirect_to search_url(q: params[:search][:q])
        when "users"
          redirect_to search_users_url(q: params[:search][:q])
        end
      end
    end

    def query_term
      params[:q] || ''
    end
end
