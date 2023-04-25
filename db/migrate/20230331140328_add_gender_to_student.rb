class AddGenderToStudent < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :gender, null: false, foreign_key: true
  end
end
