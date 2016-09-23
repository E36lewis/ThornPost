class AddIndexSlug < ActiveRecord::Migration[5.0]
  def change
	add_index :tags, :slug, unique: true
	add_index :users, :slug, unique: true
	add_index :stories, :slug, unique: true
  end
end
