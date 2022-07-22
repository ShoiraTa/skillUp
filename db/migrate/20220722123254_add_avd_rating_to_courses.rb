class AddAvdRatingToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :avg_rating, :float, default: 0.0, null: false
  end
end
