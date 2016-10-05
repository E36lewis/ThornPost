class TagsController < ApplicationController
  before_action :set_tag
  
  def show
    @dashboard = Dashboard.new(user: current_user, stories: tagged_stories, tag: @tag)
    @related_tags = @tag.related_tags
  end

  private

    def set_tag
      @tag = Tag.friendly.find(params[:id])
    end

    def tagged_stories
      @_tagged_stories ||= Story.tagged_with(@tag.name).published.includes(:user).paginate(page: params[:page])
    end
end
