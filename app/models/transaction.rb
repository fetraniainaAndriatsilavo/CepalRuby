class Transaction < ApplicationRecord
  # Associations
  belongs_to :wallet # A transaction is associated with a wallet
  belongs_to :recipient_wallet, class_name: 'Wallet', optional: true 
  # Optional association for the recipient wallet in case of a transfer

  # Validations
  validates :transaction_type, presence: true, inclusion: { in: %w[credit debit transfer] }
  # Ensures the transaction type is present and must be one of 'credit', 'debit', or 'transfer'

  validates :amount, presence: true, numericality: { greater_than: 0 }
  # Ensures the amount is present and greater than 0

  validates :status, presence: false, inclusion: { in: %w[pending completed failed] }
  # Allows status to be optional but, if provided, must be one of 'pending', 'completed', or 'failed'
end
