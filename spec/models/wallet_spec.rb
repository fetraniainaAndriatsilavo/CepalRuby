require 'rails_helper'

RSpec.describe Wallet, type: :model do
  it { should belong_to(:user) }

  it { should validate_numericality_of(:balance).is_greater_than_or_equal_to(0.0) }

  it { should have_many(:transactions).dependent(:destroy) }

  it 'is invalid with a negative balance' do
    wallet = Wallet.new(balance: -10.0)
    expect(wallet).not_to be_valid
  end

  it 'can have transactions' do
    wallet = create(:wallet)
    transaction = create(:transaction, wallet: wallet)

    expect(wallet.transactions.count).to eq(1)
    expect(wallet.transactions.first).to eq(transaction)
  end

  describe 'Wallet balance validation' do
    let(:wallet) { create(:wallet, balance: 0.0) }
    let(:debit) { create(:transaction, wallet: wallet, amount: -50.0, status: :completed) }
    let(:credit) { create(:transaction, wallet: wallet, amount: 50.0, status: :completed) }

    before do
      debit
      credit
    end

    it 'is valid when balance matches the sum of completed transactions' do
      expect(wallet).to be_valid
      expect(wallet.balance).to eq(debit.amount + credit.amount)
    end

    it 'is invalid when balance does not match the sum of completed transactions' do
      create(:transaction, wallet: wallet, amount: 100.0, status: :completed)

      expect(wallet).not_to be_valid
      expect(wallet.errors[:balance]).to include("should be equal to the sum of completed debit and credit transactions")
    end
  end
end
