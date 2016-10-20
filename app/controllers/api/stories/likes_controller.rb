class API::Stories::LikesController < API::LikesController

  private

    def set_likeable
      @likeable = Story.friendly.find(params[:story_id])
    end
end
