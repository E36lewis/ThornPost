class API::Stories::BookmarksController < API::BookmarksController

  private

    def set_bookmarkable
      @bookmarkable = Story.find(params[:story_id])
    end
end