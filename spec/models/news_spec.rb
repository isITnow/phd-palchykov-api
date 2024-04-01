# frozen_string_literal: true

require 'rails_helper'

describe News do
  let(:news) { create(:news) }

  describe '#ensure_date_has_a_value' do
    current_date = Time.zone.now.strftime('%B %e, %Y')
    context 'when date present' do
      it 'does not set the date to default (current date)' do
        expect(news.date).not_to eq(current_date)
      end
    end

    context 'when date is not present' do
      it 'sets the date to default (current date)' do
        news = create(:news, date: nil)
        expect(news.date).to eq(current_date)
      end
    end

    context 'when date is blank' do
      it 'sets the date to default (current date)' do
        news = create(:news, date: '')
        expect(news.date).to eq(current_date)
      end
    end
  end

  describe '#convert_blank_body_to_nil' do
    context 'when save news with blank body' do
      it 'converts body to nil' do
        news = create(:news, body: '')
        expect(news.body).to be_nil
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:body).is_at_least(10) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(5) }
    it { is_expected.to validate_length_of(:title).is_at_most(150) }
  end

  context 'when creating a news' do
    it 'valid with valid attributes' do
      expect(news).to be_valid
    end

    it 'is not valid with a body length of less than 10' do
      news.body = '123456789'
      expect(news).not_to be_valid
    end

    it 'is not valid without title' do
      news.title = nil
      expect(news).not_to be_valid
    end

    it 'is not valid with a title length of less than 5' do
      news.title = '1234'
      expect(news).not_to be_valid
    end

    it 'is not valid with a title length of more than 150' do
      news.title = Faker::Lorem.characters(number: 151)
      expect(news).not_to be_valid
    end
  end
end
