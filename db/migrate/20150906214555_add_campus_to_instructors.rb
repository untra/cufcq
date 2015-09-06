class AddCampusToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :campus, :string
  end
end
