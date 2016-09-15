class API::Stories::LikesController < API::LikesController

  private

    def set_likeable
      @likeable = Storie.find(params[:storie_id])
    end
end
