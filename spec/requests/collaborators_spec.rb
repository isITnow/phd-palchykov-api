# frozen_string_literal: true

require 'rails_helper'

describe 'Collaborators' do
  let(:user) { create(:user) }
  let(:collaborator) { create(:collaborator) }

  before { sign_in user }

  describe 'GET /collaborators' do
    it 'returns a successful response' do
      get collaborators_path
      expect(response).to have_http_status(:ok)
    end

    it 'returns collaborators' do
      create_list(:collaborator, 5)

      get collaborators_path
      expect(response.parsed_body.length).to eq(5)
    end
  end

  describe 'POST /collaborators' do
    let(:valid_params) do
      {
        name: 'John Doe',
        position: 'Engineer',
        category: 'local',
        link: 'https://www.dnu.dp.ua',
        photo: fixture_file_upload('spec/fixtures/default_image.jpg', 'image/jpeg')
      }
    end

    let(:invalid_params) do
      {
        name: '',
        position: '',
        category: '',
        link: '',
        photo: nil
      }
    end

    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        post collaborators_path params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid params' do
      it 'returns a successful response' do
        post '/collaborators', params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'creates a new collaborator' do
        expect do
          post '/collaborators', params: valid_params
        end.to change(Collaborator, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'returns failure response' do
        post '/collaborators', params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        post '/collaborators', params: invalid_params
        expect(response.parsed_body['message']).to include("Name can't be blank",
                                                           'Position is too short (minimum is 5 characters)',
                                                           'Photo must be attached',
                                                           'Name is too short (minimum is 5 characters)')
      end

      it 'does not create a new collaborator' do
        expect do
          post '/collaborators', params: invalid_params
        end.not_to change(Collaborator, :count)
      end
    end
  end

  describe 'PATCH /collaborator/:id' do
    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        patch collaborator_path(collaborator), params: { name: 'New Name' }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid params' do
      it 'returns a successful response' do
        patch collaborator_path(collaborator), params: { name: 'New Name' }
        expect(response).to have_http_status(:accepted)
      end

      it 'updates name' do
        patch collaborator_path(collaborator), params: { name: 'New Name' }
        expect(response.parsed_body['name']).to eq('New Name')
      end

      it 'updates category' do
        patch collaborator_path(collaborator), params: { category: 'alumni' }
        expect(response.parsed_body['category']).to eq('alumni')
      end
    end

    context 'with invalid params' do
      context 'when required attribute is nil' do
        it 'returns failure response' do
          patch collaborator_path(collaborator), params: { name: nil }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not update the collaborator' do
          patch collaborator_path(collaborator), params: { name: nil }
          test_colleague = Collaborator.find collaborator.id
          expect(test_colleague.name).to eq(collaborator.name)
        end
      end
    end
  end

  describe 'DELETE /collaborator/:id' do
    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        delete collaborator_path(collaborator)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when collaborator exists' do
      it 'returns a successful response' do
        delete collaborator_path(collaborator)
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes a collaborator' do
        create_list(:collaborator, 5)
        collaborator = Collaborator.last

        expect do
          delete collaborator_path(collaborator)
        end.to change(Collaborator, :count).by(-1)
      end
    end

    context 'when collaborator does not exist' do
      it 'returns not_found response' do
        delete collaborator_path(id: -1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
