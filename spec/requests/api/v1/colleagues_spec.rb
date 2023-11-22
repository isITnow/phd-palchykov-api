require 'rails_helper'

describe "Api::V1::Colleagues", type: :request do
  let(:user) { create(:user) }
  before { sign_in user }
  let(:colleague) { create(:colleague) }

  describe "GET /api/v1/colleagues" do
    it "returns a successful response" do
      get api_v1_colleagues_path
      expect(response).to have_http_status(:ok)
    end

    it "returns colleagues" do
      create_list(:colleague, 5)

      get api_v1_colleagues_path
      expect(JSON.parse(response.body).length).to eq(5)  
    end
  end

  describe "POST /api/v1/colleagues" do
    context "with no user signed in" do
      it "returns an unauthorized response" do
        sign_out user

        post api_v1_colleagues_path params: { colleague: colleague }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    # TODO: fix photo attachment

    # context "with valid params" do
    #   let(:params) do
    #     { colleague: {
    #         name: "Tomas",
    #         position: "colleague",
    #         photo: fixture_file_upload(Rails.root.join('spec/fixtures/default_image.jpg'), 'image/jpeg')
    #       }
    #     }
    #   end


        
    #   it "returns a successful response" do
    #     # puts valid_attributes.inspect
    #     post api_v1_colleagues_path params: params
    #     puts response.body.inspect
    #     expect(response).to have_http_status(:created)
    #   end
    # end

    # context "with invalid params" do
    #   context "attribute absence" do
    #     let(:invalid_attributes) { { name: "Tomas", position: "colleague" } }

    #     it "returns failure response" do
    #       post api_v1_colleagues_path params: {colleague: invalid_attributes}
    #       expect(response).to have_http_status(:unprocessable_entity)
    #     end

    #     it "does not create a new Colleague" do
    #       expect {
    #         post api_v1_colleagues_path params: {colleague: invalid_attributes}
    #       }.to change(Colleague, :count).by(0)
    #     end
    #   end
    # end
  end

  describe "PATCH /api/v1/colleague/:id" do
    context "with no user signed in" do
      it "returns an unauthorized response" do
        sign_out user

        patch api_v1_colleague_path(colleague), params: { colleague: {name: "New Name"} }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with valid params" do
      it "returns a successful response" do
        patch api_v1_colleague_path(colleague), params: { colleague: {name: "New Name"} }
        expect(response).to have_http_status(:accepted)
      end
      
      it "updates attributes" do
        patch api_v1_colleague_path(colleague), params: { colleague: {name: "New Name", email: "name@mail.com"} }
        expect(JSON.parse(response.body)["name"]).to eq("New Name")
        expect(JSON.parse(response.body)["email"]).to eq("name@mail.com")
      end
    end

    context "with invalid params" do
      context "required attribute is nil" do
        it "returns failure response" do
          patch api_v1_colleague_path(colleague), params: { colleague: { name: nil } }
          expect(response).to have_http_status(:unprocessable_entity)
        end
        it "does not update Colleague" do
          patch api_v1_colleague_path(colleague), params: { colleague: { name: nil } }
          @colleague = Colleague.find colleague.id
          expect(@colleague.name).to eq(colleague.name)
        end
      end
    end
    
  end

  describe "DELETE /api/v1/colleague/:id" do
    context "with no user signed in" do
      it "returns an unauthorized response" do
        sign_out user

        delete api_v1_colleague_path(colleague)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "colleague exists" do
      it "returns a successful response" do
        delete api_v1_colleague_path(colleague)
        expect(response).to have_http_status(:no_content)
      end
      
      it "deletes a Colleague" do
        create_list(:colleague, 5)
        @colleague = Colleague.last

        expect {
          delete api_v1_colleague_path(@colleague)
        }.to change(Colleague, :count).by(-1)
      end
    end
    
    context "colleague does not exist" do
      it "returns not_found response" do
        delete api_v1_colleague_path(id: -1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
