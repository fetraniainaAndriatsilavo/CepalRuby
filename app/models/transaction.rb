class Transaction < ApplicationRecord
  # Associations
  belongs_to :wallet
  belongs_to :recipient_wallet, class_name: 'Wallet', optional: true

  # Validations
  validates :transaction_type, presence: true, inclusion: { in: %w[credit debit transfer] }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: false, inclusion: { in: %w[pending completed failed] }

end
