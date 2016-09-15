class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @dashboard = Dashboard.new(posts: all_stories)
  end

  private

    def all_stories
      Storie.published
    end
end
