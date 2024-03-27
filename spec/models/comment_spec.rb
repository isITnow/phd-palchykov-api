require 'rails_helper'

describe Comment, type: :model do
  let(:comment) { create(:comment) }

  describe 'associations' do
    it { is_expected.to belong_to(:post).class_name('Post') }
  end

  describe '#ensure_author_has_a_value' do
    context 'when author present' do
      it 'does not set the author to "Guest User"' do
        expect(comment.author).not_to eq('Guest User')
      end
    end

    context 'when author is not present' do
      it 'sets the author to "Guest User"' do
        comment = create(:comment, author: nil)
        expect(comment.author).to eq('Guest User')
      end
    end

    context 'when author is blank' do
      it 'sets the author to "Guest User"' do
        comment = create(:comment, author: '')
        expect(comment.author).to eq('Guest User')
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(5) }
    it { is_expected.to validate_length_of(:body).is_at_most(700) }
  end

  context 'when creating a comment' do
    it 'valid with valid attributes' do
      expect(comment).to be_valid
    end

    it 'is not valid without body' do
      comment.body = nil
      expect(comment).not_to be_valid
    end

    it 'is not valid with a body length of less than 5' do
      comment.body = '1234'
      expect(comment).not_to be_valid
    end

    it 'is not valid wit a body length of more than 700' do
      comment.body = Faker::Lorem.characters(number: 701)
      expect(comment).not_to be_valid
    end
  end
end
