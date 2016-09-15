class AddLikePublishLeadFeatured < ActiveRecord::Migration[5.0]
  def change
	add_column :stories, :lead, :text
	add_column :stories, :likes_count, :integer, default: 0
	
	Like.destroy_all
  end
end
