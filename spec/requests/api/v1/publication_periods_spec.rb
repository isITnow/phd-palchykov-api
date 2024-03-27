# frozen_string_literal: true

require 'rails_helper'

describe 'Api::V1::PublicationPeriods' do
  let(:user) { create(:user) }
  let(:publication_period) { create(:publication_period) }

  before { sign_in user }

  describe 'GET /api/v1/publication_periods' do
    it 'returns a successful response' do
      get api_v1_publication_periods_path
      expect(response).to have_http_status(:ok)
    end

    it 'returns publication periods' do
      create_list(:publication_period, 5)

      get api_v1_publication_periods_path
      expect(response.parsed_body.length).to eq(5)
    end
  end

  describe 'POST /api/v1/publication_periods' do
    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user
        post api_v1_publication_periods_path params: { publication_period: { title: '2020-2023' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid params' do
      let(:params) do
        { publication_period: { title: '2020-2023' } }
      end

      it 'returns a successful response' do
        post api_v1_publication_periods_path(params:)
        expect(response).to have_http_status(:created)
      end

      it 'creates a new PublicationPeriod' do
        expect do
          post api_v1_publication_periods_path(params:)
        end.to change(PublicationPeriod, :count).by(1)
      end

      it 'creates the PublicationPeriod with proper title' do
        post api_v1_publication_periods_path(params:)
        publication_period = PublicationPeriod.last
        expect(publication_period.title).to eq('2020-2023')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { publication_period: { title: nil } }
      end

      it 'returns failure response' do
        post api_v1_publication_periods_path params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a new PublicationPeriod' do
        expect do
          post api_v1_publication_periods_path params: invalid_params
        end.not_to change(PublicationPeriod, :count)
      end
    end
  end

  describe 'DELETE /api/v1/publication_periods/:id' do
    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        delete api_v1_publication_period_path(publication_period)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when publication period exists' do
      it 'returns a successful response' do
        delete api_v1_publication_period_path(publication_period)
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes a PublicationPeriod' do
        create_list(:publication_period, 3)
        publication_period = PublicationPeriod.last

        expect do
          delete api_v1_publication_period_path(publication_period)
        end.to change(PublicationPeriod, :count).by(-1)
      end
    end

    context 'when publication period does not exist' do
      it 'returns not_found response' do
        delete api_v1_publication_period_path(id: -1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
