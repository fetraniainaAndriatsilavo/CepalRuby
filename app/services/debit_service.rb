class DebitService
    def initialize(wallet, amount)
      @wallet = wallet
      @amount = amount
    end
  
    def process_debit
      raise ActiveRecord::Rollback, "Insufficient balance" if sufficient_balance?
      
      ActiveRecord::Base.transaction do
        transaction = Transaction.create!(
          wallet: @wallet,
          recipient_wallet: nil,
          amount: -@amount,
          transaction_type: 'debit',
          status: 'completed'
        )

        @wallet.update!(balance: @wallet.balance - @amount)
        return transaction
      end
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Debit transaction failed: #{e.message}")
      raise ActiveRecord::Rollback
    end

    def sufficient_balance?
        @wallet.balance < @amount
    end
  end
  