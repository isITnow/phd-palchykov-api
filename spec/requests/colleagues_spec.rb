# frozen_string_literal: true

require 'rails_helper'

describe 'Colleagues' do
  let(:user) { create(:user) }
  let(:colleague) { create(:colleague) }

  before { sign_in user }

  describe 'GET /colleagues' do
    it 'returns a successful response' do
      get colleagues_path
      expect(response).to have_http_status(:ok)
    end

    it 'returns colleagues' do
      create_list(:colleague, 5)

      get colleagues_path
      expect(response.parsed_body.length).to eq(5)
    end
  end

  describe 'POST /colleagues' do
    let(:valid_params) do
      {
        name: 'John Doe',
        position: 'Engineer',
        email: 'john@example.com',
        phone: '1234567890',
        photo: fixture_file_upload('spec/fixtures/default_image.jpg', 'image/jpeg')
      }
    end

    let(:invalid_params) do
      {
        name: '',
        position: '',
        photo: nil
      }
    end

    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        post colleagues_path params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid params' do
      it 'returns a successful response' do
        post '/colleagues', params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'creates a new colleague' do
        expect do
          post '/colleagues', params: valid_params
        end.to change(Colleague, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'returns failure response' do
        post '/colleagues', params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        post '/colleagues', params: invalid_params
        expect(response.parsed_body['message']).to include("Name can't be blank",
                                                           'Position is too short (minimum is 5 characters)',
                                                           'Photo must be attached',
                                                           'Name is too short (minimum is 5 characters)')
      end

      it 'does not create a new colleague' do
        expect do
          post '/colleagues', params: invalid_params
        end.not_to change(Colleague, :count)
      end
    end
  end

  describe 'PATCH /colleague/:id' do
    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        patch colleague_path(colleague), params: { name: 'New Name' }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid params' do
      it 'returns a successful response' do
        patch colleague_path(colleague), params: { name: 'New Name' }
        expect(response).to have_http_status(:accepted)
      end

      it 'updates name' do
        patch colleague_path(colleague), params: { name: 'New Name' }
        expect(response.parsed_body['name']).to eq('New Name')
      end

      it 'updates email' do
        patch colleague_path(colleague), params: { email: 'name@mail.com' }
        expect(response.parsed_body['email']).to eq('name@mail.com')
      end
    end

    context 'with invalid params' do
      context 'when required attribute is nil' do
        it 'returns failure response' do
          patch colleague_path(colleague), params: { name: nil }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not update the colleague' do
          patch colleague_path(colleague), params: { name: nil }
          test_colleague = Colleague.find colleague.id
          expect(test_colleague.name).to eq(colleague.name)
        end
      end
    end
  end

  describe 'DELETE /colleague/:id' do
    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        delete colleague_path(colleague)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when colleague exists' do
      it 'returns a successful response' do
        delete colleague_path(colleague)
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes a Colleague' do
        create_list(:colleague, 5)
        colleague = Colleague.last

        expect do
          delete colleague_path(colleague)
        end.to change(Colleague, :count).by(-1)
      end
    end

    context 'when colleague does not exist' do
      it 'returns not_found response' do
        delete colleague_path(id: -1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
