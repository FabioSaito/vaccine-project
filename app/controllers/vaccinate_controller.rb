class VaccinateController < ApplicationController
  before_action :set_patient
  before_action :set_vaccine

  def create
    return render_response('Vaccine already registered', :unprocessable_entity) if patient_has_vaccine?

    patient_vaccines << @vaccine

    render_response('Vaccination registered', :ok)
  end

  def destroy
    return render_response('Patient does not have this vaccine', :unprocessable_entity) unless patient_has_vaccine?

    @patient.vaccine_card.vaccines.delete(@vaccine)

    render status: :no_content
  end

  private

  def set_patient
    @patient = Patient.find_by(id: params[:patient_id])

    render_response('Patient not found', :unprocessable_entity) unless @patient
  end

  def set_vaccine
    @vaccine = Vaccine.find_by(slug: params[:vaccine_slug], dose: params[:vaccine_dose])

    render_response('Invalid vaccine', :unprocessable_entity) unless @vaccine
  end

  def patient_has_vaccine?
    patient_vaccines.include?(@vaccine)
  end

  def patient_vaccines
    @patient_vaccines ||= @patient.vaccine_card.vaccines
  end

  def render_response(message, status)
    render json: { message: message}, status: status
  end
end