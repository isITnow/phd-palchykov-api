require 'rails_helper'

describe News, type: :model do
  let(:news) { create(:news) }

  describe '#ensure_date_has_a_value' do
    context "when date present" do
      it 'does not set the date to default (current date)' do
        expect(news.date).to eq(news.date)
      end
    end

    context 'when date is not present' do
      it 'sets the date to default (current date)' do
        news = create(:news, date: nil)
        expect(news.date).to eq(Time.zone.now.strftime('%B %e, %Y'))
      end
    end

    context 'when date is blank' do
      it 'sets the date to default (current date)' do
        news = create(:news, date: '')
        expect(news.date).to eq(Time.zone.now.strftime('%B %e, %Y'))
      end
    end
  end

  describe 'validations' do
    it { should validate_length_of(:body).is_at_least(10) }
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(5) }
    it { should validate_length_of(:title).is_at_most(150) }
  end

  context "when creating a news" do
    it 'valid with valid attributes' do
      expect(news).to be_valid
    end
    
    it 'is not valid with a body length of less than 10' do
      news.body = '123456789'
      expect(news).to_not be_valid
    end

    it 'is not valid without title' do
      news.title = nil
      expect(news).to_not be_valid
    end

    it 'is not valid with a title length of less than 5' do
      news.title = '1234'
      expect(news).to_not be_valid
    end

    it 'is not valid with a title length of more than 150' do
      news.title = Faker::Lorem.characters(number: 151)
      expect(news).to_not be_valid
    end
  end
end
