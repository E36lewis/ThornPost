class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
	rename_column :responses, :stories_id, :storie_id
  end
end
