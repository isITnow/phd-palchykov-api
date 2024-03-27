require 'rails_helper'

describe Colleague, type: :model do
  let(:colleague) { build(:colleague) }

  describe 'associations' do
    it { is_expected.to have_one_attached(:photo) }
  end

  describe 'validation' do
    subject { build(:colleague) }

    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(5) }
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_length_of(:position).is_at_least(5) }
  end

  context 'when creating a colleague' do
    it 'valid with valid attributes' do
      expect(colleague).to be_valid
    end

    it 'is not valid without name' do
      colleague.name = nil
      expect(colleague).not_to be_valid
    end

    it 'is not valid with a name length of less than 5' do
      colleague.name = '1234'
      expect(colleague).not_to be_valid
    end

    it 'is not valid without position' do
      colleague.position = nil
      expect(colleague).not_to be_valid
    end

    it 'is not valid with a position length of less than 5' do
      colleague.position = '1234'
      expect(colleague).not_to be_valid
    end
  end
end
