class API::Stories::BookmarksController < API::BookmarksController

  private

    def set_bookmarkable
      @bookmarkable = Storie.find(params[:storie_id])
    end
end