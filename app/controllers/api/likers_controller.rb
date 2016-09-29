class API::LikersController < ApplicationController
  before_action :authenticate_user!
  def index
    story = Story.find(params[:story_id])
    @likers = story.likers.paginate(page: params[:page], per_page: 6)
    @current_page = @likers.current_page
    @next_page = @likers.next_page
  end
end
