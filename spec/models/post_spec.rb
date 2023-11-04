require 'rails_helper'

describe Post, type: :model do
  let(:post) { create(:post) }

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:comments).class_name('Comment').dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(5) }
    it { should validate_length_of(:body).is_at_most(700) }
  end

  context "when creating an answer" do
    it 'valid with valid attributes' do
      expect(post).to be_valid
    end
    
    it 'is not valid without body' do
      post.body = nil
      expect(post).to_not be_valid
    end

    it 'is not valid with a body length of less than 5' do
      post.body = '1234'
      expect(post).to_not be_valid
    end

    it 'is not valid wit a body length of more than 700' do
      post.body = Faker::Lorem.characters(number: 701)
      expect(post).to_not be_valid
    end
  end
end
