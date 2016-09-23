class AddSlugToColumns < ActiveRecord::Migration[5.0]
  def change
	add_column :stories, :slug, :string
	add_column :tags, :slug, :string
  end
end
