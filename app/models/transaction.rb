class Transaction < ApplicationRecord
  ALLOWED_TRANSACTION_TYPES = %w[credit debit transfer].freeze
  ALLOWED_TRANSACTION_STATUSES = %w[pending completed failed].freeze
  belongs_to :wallet
  belongs_to :recipient_wallet, class_name: "Wallet", optional: true

  validates :transaction_type, inclusion: { in: ALLOWED_TRANSACTION_TYPES }
  validates :amount, numericality: true
  validates :amount, exclusion: { in: [ 0 ], message: "must be different than 0" }
  validates :status, inclusion: { in: ALLOWED_TRANSACTION_STATUSES }

  scope :completed, -> { where(status: "completed") }
  scope :debits_and_credits, -> { where(transaction_type: [ "debit", "credit" ]) }
end
