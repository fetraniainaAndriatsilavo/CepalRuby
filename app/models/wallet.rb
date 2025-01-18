class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  attribute :balance, :decimal, default: 0.0 # may set in the database level
  validates :balance, numericality: { greater_than_or_equal_to: 0.0 }
  validate :balance_is_correct

  private

  def balance_is_correct
    calculated_balance = transactions.completed.debits_and_credits.sum(:amount)

    if balance != calculated_balance
      errors.add(:balance, "should be equal to the sum of completed debit and credit transactions")
    end
  end
end
