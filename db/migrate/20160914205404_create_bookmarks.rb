class CreateBookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
	  t.integer :bookmarkable_id
	  t.string :bookmarkable_type
	  t.references :user, index: true, foreign_key: true

      t.timestamps
    end
	add_index :bookmarks, [:bookmarkable_id, :bookmarkable_type]
  end
end
