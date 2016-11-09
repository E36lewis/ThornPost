class FixAdminStory < ActiveRecord::Migration[5.0]
  def change
	rename_column :stories, :admin_id, :user_id
  end
end
