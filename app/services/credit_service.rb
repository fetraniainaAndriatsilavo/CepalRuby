class CreditService
    def initialize(wallet, amount)
      @wallet = wallet
      @amount = amount
    end

    def process_credit
      ActiveRecord::Base.transaction do
        transaction = Transaction.create!(
          wallet: @wallet,
          recipient_wallet: nil,
          amount: @amount,
          transaction_type: "credit",
          status: "completed"
        )

        @wallet.update!(balance: @wallet.balance + @amount)
        return transaction
      end
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Credit transaction failed: #{e.message}")
      raise ActiveRecord::Rollback
    end
end
