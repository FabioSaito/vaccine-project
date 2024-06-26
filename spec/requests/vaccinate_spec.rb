require 'rails_helper'

RSpec.describe "Vaccinate", type: :request do
  describe 'POST /api/v1/vaccinate' do
    let!(:patient) { Patient.create!(name: 'Joao') }
    let!(:vaccine) { Vaccine.create!(name: 'Test Vaccine', slug: 'test_vaccine', dose: 'first') }

    context 'with valid parameters' do
      let(:valid_params) { { patient_id: patient.id, vaccine_slug: vaccine.slug, vaccine_dose: vaccine.dose } }

      it 'registers a vaccination on vaccine card' do
        expect { post api_v1_vaccinate_index_path, params: valid_params }
          .to change(patient.vaccine_card.vaccines, :count).by(1)
      end

      it 'returns a success message' do
        post api_v1_vaccinate_index_path, params: valid_params

        expect(JSON.parse(response.body)['message']).to eq('Vaccination registered')
      end

      it 'returns http code 200' do
        post api_v1_vaccinate_index_path, params: valid_params

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      context 'when patient does not exist' do
        let(:invalid_params) { { patient_id: nil, vaccine_slug: 'invalid_vaccine' } }

        it 'returns an error message' do
          post api_v1_vaccinate_index_path, params: invalid_params

          expect(JSON.parse(response.body)['message']).to eq('Patient not found')
        end

        it 'returns http code 422' do
          post api_v1_vaccinate_index_path, params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when vaccine does not exist' do
        let(:invalid_params) { { patient_id: patient.id, vaccine_slug: 'invalid_vaccine' } }

        it 'does not register a vaccination' do
          expect { post api_v1_vaccinate_index_path, params: invalid_params }
            .not_to change(patient.vaccine_card.vaccines, :count)
        end

        it 'returns an error message' do
          post api_v1_vaccinate_index_path, params: invalid_params

          expect(JSON.parse(response.body)['message']).to eq('Invalid vaccine')
        end

        it 'returns http code 422' do
          post api_v1_vaccinate_index_path, params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe 'DELETE /api/v1/vaccinate' do
    let!(:patient) { Patient.create!(name: 'Joao') }
    let!(:vaccine) { Vaccine.create!(name: 'Test Vaccine', slug: 'test_vaccine', dose: 'first') }

    let(:vaccine_params) do
      {
        patient_id: patient.id,
        vaccine_slug: vaccine.slug,
        vaccine_dose: vaccine.dose
      }
    end

    context 'when patient has the vaccine' do
      before do
        patient.vaccine_card.vaccines << vaccine
      end

      it 'removes the vaccine from the patient' do
        expect { delete api_v1_vaccinate_index_path, params: vaccine_params }
          .to change(patient.vaccine_card.vaccines, :count).by(-1)

        expect(patient.vaccine_card.vaccines).not_to include(vaccine)
      end

      it 'returns http status 204' do
        delete api_v1_vaccinate_index_path, params: vaccine_params

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when patient does not have the vaccine' do
      it 'does not change the number of vaccines on patient vaccine_card' do
        expect { delete api_v1_vaccinate_index_path, params: vaccine_params }
          .not_to change(patient.vaccine_card.vaccines, :count)
      end

      it 'returns an error message' do
        delete api_v1_vaccinate_index_path, params: vaccine_params

        expect(response.parsed_body['message']).to eq('Patient does not have this vaccine')
      end

      it 'returns http status 422' do
        delete api_v1_vaccinate_index_path, params: vaccine_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end