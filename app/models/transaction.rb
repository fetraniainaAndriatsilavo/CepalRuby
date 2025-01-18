class Transaction < ApplicationRecord
  ALLOWED_TRANSACTION_TYPES = %w[credit debit transfer].freeze
  ALLOWED_TRANSACTION_STATUSES = %w[pending completed failed].freeze
  belongs_to :wallet

  validates :transaction_type, inclusion: { in: ALLOWED_TRANSACTION_TYPES }
  validates :amount, numericality: { greater_than: 0.0 }
  validates :status, inclusion: { in: ALLOWED_TRANSACTION_STATUSES }
end
