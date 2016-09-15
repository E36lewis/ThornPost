class ChangeIndexStories < ActiveRecord::Migration[5.0]
  def change
	remove_index "stories", name: "index_stories_on_user_id_and_created_at"
  end
end