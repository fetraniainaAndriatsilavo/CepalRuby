FactoryBot.define do
  factory :transaction do
    transaction_type { 'credit' }
    amount { "100.0" }
    recipient_wallet_id { 1 }
    status { 'pending' }
    association :wallet
  end
end
