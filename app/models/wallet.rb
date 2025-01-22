class Wallet < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :transactions, dependent: :destroy

  # Validations
  validates :balance, numericality: { greater_than_or_equal_to: 0 }



  def credit(amount)
    update!(balance: balance + amount)
  end

  def debit(amount)
    raise StandardError, "Insufficient balance" if balance < amount

    update!(balance: balance - amount)
  end
end
