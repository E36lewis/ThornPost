class ChangeRelationshipsColumnName < ActiveRecord::Migration[5.0]
  def change
	rename_column :responses, :storie_id, :story_id
	rename_column :taggings, :storie_id, :story_id
  end
end
