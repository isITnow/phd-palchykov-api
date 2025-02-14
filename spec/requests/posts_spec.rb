# frozen_string_literal: true

require 'rails_helper'

describe 'Posts' do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'GET /posts' do
    it 'returns a successful response' do
      get posts_path
      expect(response).to have_http_status(:ok)
    end

    it 'returns posts' do
      create_list(:post, 5)

      get posts_path
      expect(response.parsed_body.length).to eq(5)
    end
  end

  describe 'POST /posts' do
    let(:valid_params) do
      { body: Faker::Lorem.paragraph }
    end

    let(:invalid_params) do
      { body: nil }
    end

    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        post posts_path params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid params' do
      it 'returns a successful response' do
        post posts_path, params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'creates a new post' do
        expect do
          post posts_path, params: valid_params
        end.to change(Post, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'returns failure response' do
        post posts_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        post posts_path, params: invalid_params
        error_message = "Body can't be blank and Body is too short (minimum is 5 characters)"
        expect(response.parsed_body['message']).to include(error_message)
      end

      it 'does not create a new post' do
        expect do
          post posts_path, params: invalid_params
        end.not_to change(Post, :count)
      end
    end
  end

  describe 'PATCH /posts:id' do
    let(:post) { create(:post) }

    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        patch post_path(post), params: { body: Faker::Lorem.paragraph }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid params' do
      it 'returns a successful response' do
        patch post_path(post), params: { body: Faker::Lorem.paragraph }
        expect(response).to have_http_status(:accepted)
      end

      it 'updates body' do
        new_body = Faker::Lorem.paragraph
        patch post_path(post), params: { body: new_body }
        expect(response.parsed_body['body']).to eq(new_body)
      end
    end

    context 'with invalid params' do
      it 'returns failure response' do
        patch post_path(post), params: { body: '' }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the post' do
        patch post_path(post), params: { body: '' }
        test_post = Post.find post.id
        expect(test_post.body).to eq(post.body)
      end
    end
  end

  describe 'DELETE /posts:id' do
    let(:post) { create(:post) }

    context 'with no user signed in' do
      it 'returns an unauthorized response' do
        sign_out user

        delete post_path(post)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when post exists' do
      it 'returns a successful response' do
        delete post_path(post)
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes a post' do
        create_list(:post, 5)
        post = Post.last

        expect do
          delete post_path(post)
        end.to change(Post, :count).by(-1)
      end
    end

    context 'when post does not exist' do
      it 'returns not_found response' do
        delete post_path(id: -1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
