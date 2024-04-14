class PatientsController < ApplicationController
  def create
    @patient = Patient.new(name: params[:name])

    if @patient.save
      render json: { message: 'Patient was successfully created.', patient_id: @patient.id }, status: :ok
    else
      render json: { message: @patient.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
