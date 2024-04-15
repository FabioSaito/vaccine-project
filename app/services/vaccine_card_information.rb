class VaccineCardInformation < ApplicationService
  def initialize(patient)
    @patient = patient
  end

  def call
    patient_vaccines.map do |vaccine|
      {
        name: vaccine[0],
        shot_date: vaccine[1].strftime('%d-%m-%Y'),
        dose: Vaccine.human_attribute_name("dose.#{vaccine[2]}")
      }
    end
  end

  private

  def patient_vaccines
    VaccineCardsVaccine
      .joins(:vaccine)
      .where(vaccine_card: @patient.vaccine_card)
      .pluck(:name, :created_at, :dose)
  end
end