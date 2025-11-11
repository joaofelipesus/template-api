class StudentsController < ApplicationController
before_action :set_student, only: [:show, :update]

  def index
    @students = Student.all

    render json: StudentSerializer.new(@students).serializable_hash
  end

  def show
    render(
      json: StudentSerializer
        .new(@student, include: [:presences, :graduations ])
        .serializable_hash
    )
  end

  def create
    @student = Student.create_new_student!(name: student_params[:name], age: student_params[:age])

    if @student.persisted?
      render json: StudentSerializer.new(@student).serializable_hash, status: :created
    else
      render json: { errors: @student.errors.full_messages.map { |msg| { detail: msg } } }, status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      render json: StudentSerializer.new(@student).serializable_hash
    else
      render json: { errors: @student.errors.full_messages.map { |msg| { detail: msg } } }, status: :unprocessable_entity
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :age)
  end
end
