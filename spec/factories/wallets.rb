# spec/factories/wallets.rb
FactoryBot.define do
    factory :wallet do
        balance { 1000.0 }
        association :user 
    end
end