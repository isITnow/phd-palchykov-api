require 'rails_helper'

describe "Api::V1::Posts", type: :request do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET /api/v1/posts" do
    it "returns a successful response" do
      get api_v1_posts_path
      expect(response).to have_http_status(:ok)
    end

    it "returns posts" do
      create_list(:post, 5)

      get api_v1_posts_path
      expect(JSON.parse(response.body).length).to eq(5)  
    end
  end

  describe "POST /api/v1/posts" do
    let(:valid_params) do
      {
        post: {
          body: Faker::Lorem.paragraph,
        }
      }
    end

    let(:invalid_params) do
      {
        post: {
          body: nil,
        }
      }
    end

    context "with no user signed in" do
      it "returns an unauthorized response" do
        sign_out user

        post api_v1_posts_path params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with valid params" do
      it "returns a successful response" do
        post api_v1_posts_path, params: valid_params
        expect(response).to have_http_status(:created)
      end
      
      it 'creates a new post' do
        expect do
          post api_v1_posts_path, params: valid_params
        end.to change(Post, :count).by(1)
      end
    end

    context "with invalid params" do
      it "returns failure response and error message" do
        post api_v1_posts_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to include("Body can't be blank and Body is too short (minimum is 5 characters)")
      end
      
      it 'does not create a new post' do
        expect do
          post api_v1_posts_path, params: invalid_params
        end.not_to change(Post, :count)
      end
    end
  end

  describe "PATCH /api/v1/posts:id" do
    let(:post) { create(:post) }

    context "with no user signed in" do
      it "returns an unauthorized response" do
        sign_out user

        patch api_v1_post_path(post), params: { post: { body: Faker::Lorem.paragraph } }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with valid params" do
      it "returns a successful response" do
        patch api_v1_post_path(post), params: { post: { body: Faker::Lorem.paragraph } }
        expect(response).to have_http_status(:accepted)
      end
      
      it "updates body" do
        new_body = Faker::Lorem.paragraph
        patch api_v1_post_path(post), params: { post: { body: new_body } }
        expect(JSON.parse(response.body)["body"]).to eq(new_body)
      end
    end

    context "with invalid params" do
      it "returns failure response" do
        patch api_v1_post_path(post), params: { post: { body: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
      
      it "does not update the post" do
        patch api_v1_post_path(post), params: { post: { body: "" } }
        @post = Post.find post.id
        expect(@post.body).to eq(post.body)
      end
    end
  end

  describe "DELETE /api/v1/posts:id" do
    let(:post) { create(:post) }
    
    context "with no user signed in" do
      it "returns an unauthorized response" do
        sign_out user

        delete api_v1_post_path(post)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "post exists" do
      it "returns a successful response" do
        delete api_v1_post_path(post)
        expect(response).to have_http_status(:no_content)
      end
      
      it "deletes a post" do
        create_list(:post, 5)
        @post = Post.last

        expect {
          delete api_v1_post_path(@post)
        }.to change(Post, :count).by(-1)
      end
    end
    
    context "post does not exist" do
      it "returns not_found response" do
        delete api_v1_post_path(id: -1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end  
end
