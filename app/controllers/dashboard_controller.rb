class DashboardController < ApplicationController
  before_action :check_for_admin, only: [:show]
  before_action :authenticate_user!, only: [:bookmarks]

  def show
    if user_signed_in?
      @dashboard = Dashboard.new(user: current_user, stories: feed)
    else
      @dashboard = Dashboard.new(stories: featured_stories)
    end
  end

  def bookmarks
    @dashboard = Dashboard.new(user: current_user, stories: bookmarked_stories, filter: :bookmarks)
    respond_to do |format|
      format.html { render :show }
      format.js   { render :show }
    end
  end

  def top_stories
    if user_signed_in?
      @dashboard = Dashboard.new(user: current_user, posts: top_posts, filter: :top_stories)
    else
      @dashboard = Dashboard.new(posts: top_posts, filter: :top_stories)
    end
    respond_to do |format|
      format.html { render :show }
      format.js   { render :show }
    end
  end

  private

    def check_for_admin
      redirect_to admin_dashboard_url if admin_signed_in?
    end

    def feed
      Feed.new(current_user, page: params[:page])
    end

    #def bookmarked_posts
    #  current_user.bookmarked_posts.published.includes(:user).paginate(page: params[:page])
    #end

    def top_articles
      Storie.published.top_articles(5).includes(:user)
    end

    def recent_stories
      Storie.published.recent.includes(:user).paginate(page: params[:page])
    end

    def featured_storie
      Storie.recent.featured.includes(:user).paginate(page: params[:page])
    end
end
