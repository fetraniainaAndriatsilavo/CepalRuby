require 'rails_helper'

RSpec.describe Wallet, type: :model do
  it { should belong_to(:user) }

  it { should validate_numericality_of(:balance).is_greater_than_or_equal_to(0.0) }

  it 'is invalid with a negative balance' do
    wallet = Wallet.new(balance: -10.0)
    expect(wallet).not_to be_valid
  end
end
