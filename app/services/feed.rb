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
    Storie.recent.where(id: feed_storie_ids).published.includes(:user).paginate(page: page)
  end

  def tagged?(storie)
    tagged_storie_ids.include?(storie.id)
  end

  def following_author?(storie)
    following_users_storie_ids.include?(storie.id)
  end

  def recommended?(storie)
    recommended_storie_ids.include?(storie.id)
  end

  def featured?(storie)
    featured_storie_ids.include?(storie.id)
  end

  def tag_for(storie)
    tag_id = user.following_tag_ids.select { |id| storie.tag_ids.include?(id) }.first
    Tag.find_by(id: tag_id)
  end

  def recommender_for(storie)
    user_id = user.following_ids.select { |id| storie.liker_ids.include?(id) }.first
    User.find_by(id: user_id)
  end

  private

     def user_ids
       @_user_ids ||= user.following_ids + [user.id]
     end

     def following_users_storie_ids
       @_following_users_storie_ids ||= Storie.where(user_id: user.following_ids).pluck(:id)
     end

     def tagged_storie_ids
       @_tagged_storie_ids ||= Tagging.where(tag_id: user.following_tag_ids).distinct.pluck(:post_id)
     end

     def featured_storie_ids
       @_featured_storie_ids ||= Storie.where(featured: true).pluck(:id)
     end

     def feed_storie_ids
       @_feed_storie_ids ||= (Storie.where(user_id: user_ids).pluck(:id) + tagged_storie_ids + recommended_storie_ids + featured_storie_ids).uniq
     end

     def recommended_storie_ids
       @_recommended_storie_ids ||= Storie.joins(:likes).where(likes: { user_id: user.following_ids }).distinct.pluck(:id)
     end
end
