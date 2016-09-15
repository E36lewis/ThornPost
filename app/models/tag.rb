class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :stories, through: :taggings

  has_many :interests, dependent: :destroy
  has_many :followers, through: :interests, source: :follower

  has_many :tag_relationships, -> { order(relevance: :desc) }, dependent: :destroy
  has_many :related_tags, through: :tag_relationships, source: :related_tag

  validates :name, presence: true

  include SearchableTag

  extend FriendlyId
  friendly_id :name, use: [ :slugged, :finders ]

  def self.first_or_create_with_name!(name)
    where(lowercase_name: name.strip.downcase).first_or_create! do |tag|
      tag.name = name.strip
    end
  end
end
