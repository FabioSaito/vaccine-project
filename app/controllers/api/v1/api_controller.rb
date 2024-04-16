module Api
  module V1
    class ApiController < ActionController::API
      private

      def set_patient
        @patient = Patient.find_by(id: params[:patient_id])

        render_response('Patient not found', :unprocessable_entity) unless @patient
      end

      def current_patient
        @patient = Patient.find_by(id: params[:id])

        render_response('Patient not found', :unprocessable_entity) unless @patient
      end

      def set_vaccine
        @vaccine = Vaccine.find_by(slug: params[:vaccine_slug], dose: params[:vaccine_dose])

        render_response('Invalid vaccine', :unprocessable_entity) unless @vaccine
      end

      def render_response(message, status)
        render json: { message: message }, status: status
      end
    end
  end
end