class AddDepartmentToCourse < ActiveRecord::Migration[7.0]
  def change
    add_reference :courses, :department, null: false, foreign_key: true
  end
end
