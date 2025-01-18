class User < ApplicationRecord
    has_one :wallet, dependent: :destroy

    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: true }, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password_digest, presence: true
end
