class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def drafts
    @drafts = current_user.stories.recent.drafts
  end

  def published
    @stories = current_user.stories.recent.published
  end
end
