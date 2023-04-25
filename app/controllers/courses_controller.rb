class CoursesController < ApplicationController
    # Get ALL
    def index
        courses = Course.joins(:department).all
         mappedCourses = courses.map do |course|
           {
            id: course.id,
            name:course.name,
            description:course.description,
           credits: course.credits,
           depName: course.department.name,
           depId: course.department.id
        }
        end
        render json:mappedCourses, status: :ok
    end

    # Get ONE
    def show
        begin
            course = Course.includes(:department).find(params[:id])
            mappedCourse = {
            id: course.id,
            name: course.name,
            description: course.description,
            credits: course.credits,
            depName: course.department.name,
            depId: course.department.id
            }
            render json: mappedCourse, status: :ok
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Course not found" }, status: :not_found
        end
    end

    # create NEW
    def create
        course = Course.new(course_params)
        if course.save
        render json:course, status: :ok
        else
        render json:{error:"try again later"}, status: :error
        end
    end

    # update ONE
    def update
        begin
            course = Course.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Course not found" }, status: :not_found
            return
        rescue ActiveRecord::RecordInvalid
            render json: { error: "Invalid course parameters" }, status: :unprocessable_entity
            return
        rescue ArgumentError
            render json: { error: "Invalid course ID" }, status: :unprocessable_entity
            return
        end

        if course.update(course_params)
            render json: course, status: :ok
        else
            render json: { error: "Unable to update course" }, status: :unprocessable_entity
        end
    end

    # delete ONE
    def destroy
        begin
            course = Course.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Course not found" }, status: :not_found
            return
        rescue ArgumentError
            render json: { error: "Invalid course ID" }, status: :unprocessable_entity
            return
        end

        course.destroy
        render json: course, status: :ok
    end
    
    private
    def course_params
        params.require(:course).permit(:name, :description, :credits,:department_id)
    end
end