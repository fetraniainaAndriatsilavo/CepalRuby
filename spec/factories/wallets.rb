# spec/factories/wallets.rb
FactoryBot.define do
    factory :wallet do
        balance { 0.0 }
        association :user
    end
end
