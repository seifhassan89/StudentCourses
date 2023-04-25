class DepartmentsController < ApplicationController
    # Get ALL
    def index
        departments = Department.all
        render json:departments, status: :ok
    end

    # Show ONE
    def show
        department = Department.find(params[:id])
        if department.nil?
            render json: { message: 'Department not found' }, status: :not_found
        else
            render json:department, status: :ok
        end
    end

    # create NEW
    def create
        department = Department.new(department_params)
        if department.save
        render json:department, status: :ok
        else
        render json:{error:"try again later"}, status: :error
        end
    end

    # update ONE
    def update
        begin
            department = Department.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Department not found" }, status: :not_found
            return
        rescue ActiveRecord::RecordInvalid
            render json: { error: "Invalid department parameters" }, status: :unprocessable_entity
            return
        rescue ArgumentError
            render json: { error: "Invalid department ID" }, status: :unprocessable_entity
            return
        end

        if department.update(department_params)
            render json: department, status: :ok
        else
            render json: { error: "Unable to update department" }, status: :unprocessable_entity
        end
    end

    # delete ONE
    def destroy
        begin
            department = Department.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Department not found" }, status: :not_found
            return
        rescue ArgumentError
            render json: { error: "Invalid department ID" }, status: :unprocessable_entity
            return
        end

        department.destroy
        render json: department, status: :ok
    end
    
    private
    def department_params
        params.require(:department).permit(:name)
    end
end

