module Api
  module V1
    class PatientsController < ApiController
      before_action :current_patient , only: [:destroy, :vaccine_card_informations]

      def create
        @patient = Patient.new(name: params[:name])

        if @patient.save
          render json: { message: 'Patient was successfully created.', patient_id: @patient.id }, status: :ok
        else
          render json: { message: @patient.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @patient.destroy

        render status: :no_content
      end

      def vaccine_card_informations
        render json: VaccineCardInformation.call(@patient), status: :ok
      end
    end
  end
end