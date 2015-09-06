class AddCampusToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :campus, :string
  end
end
