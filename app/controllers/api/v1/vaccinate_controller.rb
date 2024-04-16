module Api
  module V1
    class VaccinateController < ApiController
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

      def patient_has_vaccine?
        patient_vaccines.include?(@vaccine)
      end

      def patient_vaccines
        @patient_vaccines ||= @patient.vaccine_card.vaccines
      end
    end
  end
end