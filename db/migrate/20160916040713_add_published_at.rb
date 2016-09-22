class AddPublishedAt < ActiveRecord::Migration[5.0]
  def change
	add_column :stories, :published_at, :datetime
  end
end
