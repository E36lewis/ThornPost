class Admin::FeaturedStoriesController < ApplicationController
  before_action :authenticate_admin!

  def create
    storie.update(featured: true)
    redirect_to storie
  end

  def destroy
    storie.update(featured: false)
    redirect_to storie
  end

  private

    def storie
      @_storie ||= Storie.find(params[:storie_id])
    end
end