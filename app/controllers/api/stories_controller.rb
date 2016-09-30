class API::StoriesController < ApplicationController
  before_action :authenticate_user!

  def update
    @story = current_user.stories.find(params[:id])
    @story.assign_attributes(story_params)
    if @story.published?
      @story.save
    else
      @story.save_as_draft
    end
  end

  def destroy
    @story = current_user.stories.find(params[:id])
    @story.destroy
  end

  private

  def story_params
      params.require(:story).permit(:title, :body, :all_tags, :picture)
  end
end