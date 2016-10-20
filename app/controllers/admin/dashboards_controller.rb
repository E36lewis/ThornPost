class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @dashboard = Dashboard.new(stories: all_stories)
  end

  private

    def all_stories
      Story.published.recent
    end
end
