require 'rails_helper'

RSpec.describe "Patients", type: :request do
  describe 'POST /patients' do
    context 'with valid parameters' do
      let(:valid_params) { { name: 'Joao' } }

      it 'creates a new patient' do
        expect { post patients_path, params: valid_params }
          .to change(Patient, :count).by(1)
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
        expect { post patients_path, params: invalid_params }
          .not_to change(Patient, :count)
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

  describe 'DELETE #destroy' do
    let!(:patient) { Patient.create!(name: 'Ze') }

    it 'deletes the patient' do
      delete patient_path(patient.id)

      expect(Patient.exists?(patient.id)).to be false
    end

    it 'returns http code 204' do
      delete patient_path(patient.id)

      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'GET /vaccine_card_informations' do
    context 'when patient exists' do
      let(:patient) { Patient.create!(name: 'Joao') }
      let(:vaccine_first) { Vaccine.create!(name: 'Tetra Valente', slug: 'tetra_valente', dose: 'first') }
      let(:vaccine_first_booster) { Vaccine.create!(name: 'Tetra Valente', slug: 'tetra_valente', dose: 'first_booster') }

      let(:expected_response) do
        [
          {
            "name"=>"Tetra Valente",
            "shot_date"=>DateTime.current.strftime('%d-%m-%Y'),
            "dose"=>"Primeira dose"
          },
          {
            "name"=>"Tetra Valente",
            "shot_date"=>DateTime.current.strftime('%d-%m-%Y'),
            "dose"=>"Primeira dose de reforço"
          }
        ]
      end

      it 'returns a status code of 200' do
        get vaccine_card_patient_path(patient)

        expect(response).to have_http_status(:ok)
      end


      context 'when patient has vaccines' do
        before do
          patient.vaccine_card.vaccines << vaccine_first
          patient.vaccine_card.vaccines << vaccine_first_booster
        end

        it 'returns the vaccine card information' do
          get vaccine_card_patient_path(patient)

          expect(response.parsed_body).to eq(expected_response)
        end
      end

      context 'when patient has no vaccines' do
        it 'returns empty vaccine card information' do
          get vaccine_card_patient_path(patient)

          expect(response.parsed_body).to eq([])
        end
      end
    end

    context 'when patient does not exist' do
      it 'returns a status code of 422' do
        get vaccine_card_patient_path(-1)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        get vaccine_card_patient_path(-1)

        expect(response.parsed_body['message']).to eq('Patient not found')
      end
    end
  end
end