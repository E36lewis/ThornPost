class API::StoriesController < ApplicationController
  before_action :authenticate_user!

  def update
    @storie = current_user.stories.find(params[:id])
    @storie.assign_attributes(storie_params)
    if @storie.published?
      @storie.save
    else
      @storie.save_as_draft
    end
  end

  def destroy
    @storie = current_user.stories.find(params[:id])
    @storie.destroy
  end

  private

    def storie_params
      params.require(:storie).permit(:title, :body, :all_tags, :picture)
    end
end