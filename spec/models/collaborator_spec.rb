# frozen_string_literal: true

require 'rails_helper'

describe Collaborator do
  let(:collaborator) { build(:collaborator) }

  describe 'associations' do
    it { is_expected.to have_one_attached(:photo) }
  end

  describe 'validation' do
    subject { build(:collaborator) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_uniqueness_of(:link) }
    it { is_expected.to validate_length_of(:name).is_at_least(5) }
    it { is_expected.to validate_length_of(:position).is_at_least(5) }
  end

  context 'when creating a collaborator' do
    it 'valid with valid attributes' do
      expect(collaborator).to be_valid
    end

    it 'is not valid without name' do
      collaborator.name = nil
      expect(collaborator).not_to be_valid
    end

    it 'is not valid with a name length of less than 5' do
      collaborator.name = '1234'
      expect(collaborator).not_to be_valid
    end

    it 'is not valid without position' do
      collaborator.position = nil
      expect(collaborator).not_to be_valid
    end

    it 'is not valid with a position length of less than 5' do
      collaborator.position = '1234'
      expect(collaborator).not_to be_valid
    end
  end
end
