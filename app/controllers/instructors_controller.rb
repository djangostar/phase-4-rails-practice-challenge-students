class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessability_response

  def index
    instructors = Instructor.all
    render json: instructors, status: :ok
  end
  
  def show
    instructor = find_instructor
    render json: instructor, status: :ok
  end

  def create
    instructor = Instructor.create!(instructor_param)
    render json: instructor, status: :created
  end

  def update
    instructor = find_instructor
    instructor.update(instructor_param)
    render json: instructor, status: :updated
  end

  def destroy
    instructor = find_instructor
    instructor.destroy
    head :no_content
  end

  private

  def render_not_found_response
    render json:  { errors: "Instructor not found" }, status: :not_found
  end

  def render_unprocessability_response(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end
end
