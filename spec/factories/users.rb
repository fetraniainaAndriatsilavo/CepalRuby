FactoryBot.define do
    factory :user do
        name { 'Koto Ranaivo' }
        email { 'koto.ranaivo@gmail.com' }
        password_digest { 'password123' }
    end
end
