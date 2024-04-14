require 'rails_helper'

RSpec.describe "Vaccines", type: :request do
  describe 'POST /vaccines' do
    context 'with valid parameters' do
      let(:valid_params) { { name: 'Tetra Valente' } }

      it 'creates a new vaccine' do
        expect { post vaccines_path, params: valid_params }.to change(Vaccine, :count).by(1)
      end

      it 'returns a success message' do
        post vaccines_path, params: valid_params

        expect(response.parsed_body['message']).to eq('Vaccine was successfully created.')
      end

      it 'returns http status 200' do
        post vaccines_path, params: valid_params

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { name: nil } }

      it 'does not create a new vaccine' do
        expect { post vaccines_path, params: invalid_params }.not_to change(Vaccine, :count)
      end

      it 'returns an error message' do
        post vaccines_path, params: invalid_params

        expect(response.parsed_body['message']).to include('Name is mandatory')
      end

      it 'returns http status 422' do
        post vaccines_path, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end