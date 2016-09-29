class Response < ApplicationRecord
  validates :body, presence: true
  validates :story_id, :user_id, presence: true

  belongs_to :story, counter_cache: true
  belongs_to :user
  has_many :likes, as: :likeable
  has_many :likers, through: :likes, source: :user

  has_many :bookmarks, as: :bookmarkable
  has_many :bookmarkers, through: :bookmarks, source: :user

  delegate :username, to: :user
end
