class Feed
  include ActiveModel::Model
  attr_reader :user, :page

  def initialize(user, page: nil)
    @user = user
    @page = page
  end

  def method_missing(method, *args, &block)
    stories.send(method, *args, &block)
  end

  def respond_to_missing?(method, include_private = false)
    stories.respond_to?(method, include_private) || super
  end

  def stories
    Story.recent.where(id: feed_story_ids).published.includes(:user).paginate(page: page)
  end

  def tagged?(story)
    tagged_story_ids.include?(story.id)
  end

  def following_author?(story)
    following_users_story_ids.include?(story.id)
  end

  def recommended?(story)
    recommended_story_ids.include?(story.id)
  end

  def featured?(story)
    featured_story_ids.include?(story.id)
  end

  def tag_for(story)
    tag_id = user.following_tag_ids.select { |id| story.tag_ids.include?(id) }.first
    Tag.find_by(id: tag_id)
  end

  def recommender_for(story)
    user_id = user.following_ids.select { |id| story.liker_ids.include?(id) }.first
    User.find_by(id: user_id)
  end

  private

     def user_ids
       @_user_ids ||= user.following_ids + [user.id]
     end

     def following_users_story_ids
       @_following_users_story_ids ||= Story.where(user_id: user.following_ids).pluck(:id)
     end

     def tagged_story_ids
       @_tagged_story_ids ||= Tagging.where(tag_id: user.following_tag_ids).distinct.pluck(:story_id)
     end

     def featured_story_ids
       @_featured_story_ids ||= Story.where(featured: true).pluck(:id)
     end

     def feed_story_ids
       @_feed_story_ids ||= (Story.where(user_id: user_ids).pluck(:id) + tagged_story_ids + recommended_story_ids + featured_story_ids).uniq
     end

     def recommended_story_ids
       @_recommended_story_ids ||= Story.joins(:likes).where(likes: { user_id: user.following_ids }).distinct.pluck(:id)
     end
end
