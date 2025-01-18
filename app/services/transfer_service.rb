class TransferService
    def initialize(transaction)
      @transaction = transaction
      @sender_wallet = @transaction.wallet
      @recipient_wallet = @transaction.recipient_wallet
    end

    def process_transfer
      return false if recipient_wallet_nil?
      return false unless sufficient_balance?

      ActiveRecord::Base.transaction do
        DebitService.new(@sender_wallet, @transaction.amount).process_debit
        CreditService.new(@recipient_wallet, @transaction.amount).process_credit
        @transaction.update!(status: "completed")
      end

      true
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Transfer transaction failed: #{e.message}")
      @transaction.update!(status: "failed")
      raise ActiveRecord::Rollback
    end

    private

    def recipient_wallet_nil?
      @recipient_wallet.nil?
    end

    def sufficient_balance?
      @sender_wallet.balance >= @transaction.amount
    end
end
