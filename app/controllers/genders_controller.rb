class GendersController < ApplicationController
    # Get ALL
    def index
        genders = Gender.all
        render json:genders, status: :ok
    end
    # Show ONE
    def show
        gender = Gender.find(params[:id])
        if gender.nil?
            render json: { message: 'Gender not found' }, status: :not_found
        else
            render json: gender, status: :ok
        end
    end

    # create NEW
    def create
        gender = Gender.new(gender_params)
        if gender.save
            render json:gender, status: :ok
        else
           render json: {error:"try again later"}, status: :error
        end
    end

    # update ONE
    def update
        begin
            gender = Gender.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Gender not found" }, status: :not_found
            return
        rescue ArgumentError
            render json: { error: "Invalid gender ID" }, status: :unprocessable_entity
            return
        end

        if gender.update(gender_params)
            render json: gender, status: :ok
        else
            render json: { error: "Unable to update gender" }, status: :unprocessable_entity
        end
    end

    # delete ONE
    def destroy
        begin
            gender = Gender.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Gender not found" }, status: :not_found
            return
        rescue ArgumentError
            render json: { error: "Invalid gender ID" }, status: :unprocessable_entity
            return
        end

        gender.destroy
        render json: gender, status: :ok
    end
    
    private
    def gender_params
        params.require(:gender).permit(:name)
    end
end
