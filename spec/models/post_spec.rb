require 'rails_helper'

describe Post, type: :model do
  let(:post) { create(:post) }

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:comments).class_name('Comment').dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
  end

  context "when creating an answer" do
    it 'valid with valid attributes' do
      expect(post).to be_valid
    end
    
    it 'is not valid without body' do
      post.body = nil
      expect(post).to_not be_valid
    end
  end
end
