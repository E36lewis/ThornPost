class Stories < ActiveRecord::Migration[5.0]
  def change
	create_table :stories do |t|
      t.string :title
      t.text :body
	  t.string :picture
	  t.references :user, foreign_key: true
	  t.boolean  :featured,        default: false

      t.timestamps 
    end
	add_index :stories, [:user_id, :created_at]
  end
end
