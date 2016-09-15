class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
	  t.text :body
      t.references :stories, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
	  t.integer   :likes_count,   default: 0
      
	  t.timestamps  null: false
    end
  end
end