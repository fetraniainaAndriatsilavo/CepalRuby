require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should belong_to(:wallet) }

  it { should validate_inclusion_of(:transaction_type).in_array(Transaction::ALLOWED_TRANSACTION_TYPES) }

  it { should validate_numericality_of(:amount).is_greater_than(0.0) }

  it { should validate_inclusion_of(:status).in_array(Transaction::ALLOWED_TRANSACTION_STATUSES) }

  context 'when creating a transaction' do
    it 'is valid with valid attributes' do
      wallet = create(:wallet)
      transaction = build(:transaction, wallet: wallet)
      expect(transaction).to be_valid
    end

    it 'is invalid without a wallet' do
      transaction = build(:transaction, wallet: nil)
      expect(transaction).not_to be_valid
    end

    it 'is invalid with an amount less than or equal to 0' do
      wallet = create(:wallet)
      transaction = build(:transaction, amount: 0, wallet: wallet)
      expect(transaction).not_to be_valid
    end

    it 'is invalid with an invalid transaction_type' do
      wallet = create(:wallet)
      transaction = build(:transaction, transaction_type: 'new_transaction_type_not_defined', wallet: wallet)
      expect(transaction).not_to be_valid
    end

    it 'is invalid with an invalid status' do
      wallet = create(:wallet)
      transaction = build(:transaction, status: 'new_status_not_defined', wallet: wallet)
      expect(transaction).not_to be_valid
    end
  end
end
