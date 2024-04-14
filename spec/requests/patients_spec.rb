require 'rails_helper'

RSpec.describe "Patients", type: :request do
  describe 'POST /patients' do
    context 'with valid parameters' do
      let(:valid_params) { { name: 'Joao' } }

      it 'creates a new patient' do
        expect { post patients_path, params: valid_params }.to change(Patient, :count).by(1)
      end

      it 'returns a success message' do
        post patients_path, params: valid_params

        expect(response.parsed_body['message']).to eq('Patient was successfully created.')
      end

      it 'returns http status 200' do
        post patients_path, params: valid_params

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { name: nil } }

      it 'does not create a new patient' do
        expect { post patients_path, params: invalid_params }.not_to change(Patient, :count)
      end

      it 'returns an error message' do
        post patients_path, params: invalid_params

        expect(response.parsed_body['message']).to include('Name is mandatory')
      end

      it 'returns http status 422' do
        post patients_path, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end