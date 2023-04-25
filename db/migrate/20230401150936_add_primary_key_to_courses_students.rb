class AddPrimaryKeyToCoursesStudents < ActiveRecord::Migration[7.0]
   def change
    add_column :courses_students, :id, :primary_key
  end
end
