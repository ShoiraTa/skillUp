class AddPublishedToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :published, :boolean, default: false
    add_column :courses, :approved, :boolean, default: false
  end
end
