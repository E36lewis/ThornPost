class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.belongs_to :storie, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true

      t.timestamps
    end
  end
end
