class Student < ApplicationRecord
    belongs_to :gender
    has_and_belongs_to_many :courses
end
