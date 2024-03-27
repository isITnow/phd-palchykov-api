require 'rails_helper'

describe 'Api::V1::Colleagues', type: :request do
  let(:user) { create(:user) }
  before { sign_in user }
  let(:colleague) { create(:colleague) }

  describe 'GET /api/v1/colleagues' do
    it 'returns a successful response' do
      get api_v1_colleagues_path
      expect(response).to have_http_status(:ok)
    end

    it 'returns colleagues' do
      create_list(:colleague, 5)

      get api_v1_colleagues_path
      expect(JSON.parse(response.body).length).to eq(5)
    end
  end

  describe 'POST /api/v1/colleagues' do
    let(:valid_params) do
      {
        colleague: {
          name: 'John Doe',
          position: 'Engineer',
          email: 'john@example.com',
          phone: '1234567890',
          photo: fixture_file_upload('spec/fixtures/default_image.jpg', 'image/jpeg')
        }
      }
    end

    let(:invalid_params) do
      {
        colleague: {
          name: '',
          position: '',
          photo: nil
        }
      }
    end

    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        post api_v1_colleagues_path params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid params' do
      it 'returns a successful response' do
        post '/api/v1/colleagues', params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'creates a new colleague' do
        expect do
          post '/api/v1/colleagues', params: valid_params
        end.to change(Colleague, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'returns failure response and error message' do
        post '/api/v1/colleagues', params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)

        expect(JSON.parse(response.body)['error']).to include("Name can't be blank",
                                                              'Position is too short (minimum is 5 characters)',
                                                              "Photo can't be blank",
                                                              'Name is too short (minimum is 5 characters)')
      end

      it 'does not create a new colleague' do
        expect do
          post '/api/v1/colleagues', params: invalid_params
        end.not_to change(Colleague, :count)
      end
    end
  end

  describe 'PATCH /api/v1/colleague/:id' do
    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        patch api_v1_colleague_path(colleague), params: { colleague: { name: 'New Name' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid params' do
      it 'returns a successful response' do
        patch api_v1_colleague_path(colleague), params: { colleague: { name: 'New Name' } }
        expect(response).to have_http_status(:accepted)
      end

      it 'updates attributes' do
        patch api_v1_colleague_path(colleague), params: { colleague: { name: 'New Name', email: 'name@mail.com' } }
        expect(JSON.parse(response.body)['name']).to eq('New Name')
        expect(JSON.parse(response.body)['email']).to eq('name@mail.com')
      end
    end

    context 'with invalid params' do
      context 'required attribute is nil' do
        it 'returns failure response' do
          patch api_v1_colleague_path(colleague), params: { colleague: { name: nil } }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not update the colleague' do
          patch api_v1_colleague_path(colleague), params: { colleague: { name: nil } }
          @colleague = Colleague.find colleague.id
          expect(@colleague.name).to eq(colleague.name)
        end
      end
    end
  end

  describe 'DELETE /api/v1/colleague/:id' do
    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        delete api_v1_colleague_path(colleague)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'colleague exists' do
      it 'returns a successful response' do
        delete api_v1_colleague_path(colleague)
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes a Colleague' do
        create_list(:colleague, 5)
        @colleague = Colleague.last

        expect do
          delete api_v1_colleague_path(@colleague)
        end.to change(Colleague, :count).by(-1)
      end
    end

    context 'colleague does not exist' do
      it 'returns not_found response' do
        delete api_v1_colleague_path(id: -1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
