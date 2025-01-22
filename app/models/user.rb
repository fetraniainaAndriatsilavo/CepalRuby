class User < ApplicationRecord
    has_secure_password

    # Associations
    #user has one wallet
    has_one :wallet, dependent: :destroy
    # has_many :transactions, through: :wallet
    has_many :transactions, dependent: :destroy
  
    # Validations
    validates :name, presence: true #user must have name
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } #email must be unique
    validates :password, presence: true, length: { minimum: 8 } if :password_required? #password only required for a new record

    private

    def password_required?
      new_record? || password.blank?
    end
end
