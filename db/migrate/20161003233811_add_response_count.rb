class AddResponseCount < ActiveRecord::Migration[5.0]
  def change
	add_column :stories, :responses_count, :integer, null: false, default: 0
	#reset cashed counts for stories with responses	
	ids = Set.new
	Response.all.find_each { |r| ids << r.story_id }
	ids.each do |story_id|
		Story.reset_counters(story_id, :responses)
	end
  end
end
