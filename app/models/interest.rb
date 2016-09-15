class Interest < ApplicationRecord
	belongs_to :follower, class_name: "User"
	belongs_to :tag
	
	validates :follower_id, pressence: true
	validates :tag_id, pressence: true
end
