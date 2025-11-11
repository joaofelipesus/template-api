class PresencesController < ApplicationController
  def create
    student = Student.find(presence_params[:student_id])

    presence = student.add_presence

    if presence
      render json: PresenceSerializer.new(presence, include: [:current_belt]).serializable_hash
    else
      render json: { errors: [{ title: "cant create presence try again later" }] }, status: :unprocessable_entity
    end
  end

  private

  def presence_params
    params.require(:presence).permit(:student_id)
  end
end
