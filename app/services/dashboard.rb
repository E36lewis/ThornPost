class Dashboard
  attr_reader :user, :stories, :tag, :filter

  def initialize(user: nil, stories: nil, tag: nil, filter: nil )
    @user = user
    @stories = stories
    @tag = tag
    @filter = filter
  end

  def featured_tags
    Tag.where(featured: true)
  end

  def following_tags
    user.following_tags unless user.nil?
  end

  def all_tags
    Tag.all.limit(50)
  end

  def top_articles
    Story.published.top_articles(5).includes(:user)
  end

  def new_story
    @user.stories.new
  end

  def filtered?
    filter.present?
  end

  def top_articles?
    filter == :top_articles
  end
end
