require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_one(:wallet).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }

    it { should validate_uniqueness_of(:email) }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    it { should validate_presence_of(:password_digest) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
