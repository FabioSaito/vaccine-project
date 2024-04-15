require 'rails_helper'

RSpec.describe "Vaccinate", type: :request do
  let!(:patient) { Patient.create!(name: 'Joao') }
  let!(:vaccine) { Vaccine.create!(name: 'Test Vaccine', slug: 'test_vaccine', dose: 'first') }

  describe 'POST /vaccinate' do
    context 'with valid parameters' do
      let(:valid_params) { { patient_id: patient.id, vaccine_slug: vaccine.slug, vaccine_dose: vaccine.dose } }

      it 'registers a vaccination on vaccine card' do
        expect { post vaccinate_index_path, params: valid_params }
          .to change(patient.vaccine_card.vaccines, :count).by(1)
      end

      it 'returns a success message' do
        post vaccinate_index_path, params: valid_params

        expect(JSON.parse(response.body)['message']).to eq('Vaccination registered')
      end

      it 'returns http code 200' do
        post vaccinate_index_path, params: valid_params

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      context 'when patient does not exist' do
        let(:invalid_params) { { patient_id: nil, vaccine_slug: 'invalid_vaccine' } }

        it 'returns an error message' do
          post vaccinate_index_path, params: invalid_params

          expect(JSON.parse(response.body)['message']).to eq('Patient not found')
        end

        it 'returns http code 422' do
          post vaccinate_index_path, params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when vaccine does not exist' do
        let(:invalid_params) { { patient_id: patient.id, vaccine_slug: 'invalid_vaccine' } }

        it 'does not register a vaccination' do
          expect { post vaccinate_index_path, params: invalid_params }
            .not_to change(patient.vaccine_card.vaccines, :count)
        end

        it 'returns an error message' do
          post vaccinate_index_path, params: invalid_params

          expect(JSON.parse(response.body)['message']).to eq('Invalid vaccine')
        end

        it 'returns http code 422' do
          post vaccinate_index_path, params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end