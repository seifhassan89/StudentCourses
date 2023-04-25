class StudentsController < ApplicationController
    # GET all
    def index
        students = Student
        .joins(:gender)
        .joins(courses_students: :course)
        .select('students.id,
                students.first_name,
                students.last_name,
                students.age,
                students.created_at,
                students.updated_at,
                students.gender_id,
                genders.name as gender_name,
                courses.id as course_id,
                courses.name as course_name,
                courses.description as course_description,
                courses.credits as course_credits,
                courses.department_id as course_department_id'
            )
        .order('students.id, courses.id')
        .group_by{|s| [s[:id],
                        s[:first_name],
                        s[:last_name],
                        s[:age],
                        s[:created_at],
                        s[:updated_at],
                        s[:gender_id],
                        s[:gender_name]]
        }
        .map{|(id, first_name, last_name, age, created_at, updated_at, gender_id, gender_name), students|
            {
            id: id,
            first_name: first_name,
            last_name: last_name,
            age: age,
            gender_id: gender_id,
            gender_name: gender_name,
            courses: students.map{|s| {
                id: s[:course_id],
                name: s[:course_name],
                description: s[:course_description],
                credits: s[:course_credits],
                department_id: s[:course_department_id]
            }}
            }
        }
        render json: students, status: :ok
    end

    # GET one
    def show
        student = Student.joins(:gender).joins(courses_students: :course).find_by(id: params[:id])
        if student.present?
        courses = student.courses.map do |course|
        {
            id: course.id,
            name: course.name,
            description: course.description,
            credits: course.credits,
            department_id: course.department.id,
            department_name: course.department.name
        }
        end
        render json: {
        id: student.id,
        first_name: student.first_name,
        last_name: student.last_name,
        age: student.age,
        genderId: student.gender.id,
        genderName: student.gender.name,
        courses: courses
        }, status: :ok
        else
            render json: { message: 'Student not found' }, status: :not_found
        end
    end

    # POST new
    def create
        student = Student.new(student_params)
        course_ids = params[:course_ids] || []
        if student.save
            student.courses << Course.where(id: course_ids)
            render json: student, status: :created
        else
            render json: student.errors, status: :unprocessable_entity
        end
    end

    # PUT update
    def update
        begin
            student = Student.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Student not found" }, status: :not_found
            return
        rescue ArgumentError
            render json: { error: "Invalid student ID" }, status: :unprocessable_entity
            return
        end

        course_ids = params[:course_ids] || []

        if student.update(student_params)
            begin
            student.courses = Course.find(course_ids)
            rescue ActiveRecord::RecordNotFound => e
            render json: { error: e.message }, status: :unprocessable_entity
            return
            end
            render json: student, status: :ok
        else
            render json: student.errors, status: :unprocessable_entity
        end
    end

    # DELETE
    def destroy
        begin
            student = Student.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Student not found" }, status: :not_found
            return
        rescue ArgumentError
            render json: { error: "Invalid student ID" }, status: :unprocessable_entity
            return
        end

        student.destroy
        render json: student, status: :ok
    end
    
    private
    def student_params
        params.require(:student).permit(:id,:first_name, :last_name, :age, :gender_id, :course_ids)
    end
end