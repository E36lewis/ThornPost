class CreateInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :interests do |t|
	  t.integer :follower_id
	  t.integer :tag_id

      t.timestamps
    end
	add_index :interests, :follower_id
	add_index :interests, :tag_id
	add_index :interests, [:follower_id, :tag_id], unique: true
  end
end
