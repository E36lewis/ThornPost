class Admin::FeaturedStoriesController < ApplicationController
  before_action :authenticate_admin!

  def create
    story.update(featured: true)
    redirect_to story
  end

  def destroy
    story.update(featured: false)
    redirect_to story
  end

  private

    def storie
      @_story ||= Story.find(params[:story_id])
    end
end