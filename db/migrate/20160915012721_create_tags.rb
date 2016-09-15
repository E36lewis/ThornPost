class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
	  t.string :name
	  t.string :lowercase_name
	  t.boolean :featured, default: false

      t.timestamps
    end
	add_index :tags, :name
  end
end
