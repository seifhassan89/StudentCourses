class Course < ApplicationRecord
    belongs_to :department
    has_and_belongs_to_many :students
end
