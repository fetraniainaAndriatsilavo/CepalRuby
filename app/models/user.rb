class User < ApplicationRecord
    has_secure_password

    # Associations
    has_one :wallet, dependent: :destroy
    # has_many :transactions, through: :wallet
    has_many :transactions, dependent: :destroy
  
    # Validations
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 8 } if :password_required?

    private

    def password_required?
      new_record? || password.blank?
    end
end
