class TransactionService
    attr_reader :wallet, :transaction_type, :amount, :recipient_wallet, :errors, :transaction
    
    def initialize(wallet, transaction_type, amount, recipient_wallet = nil)
      @wallet = wallet
      @transaction_type = transaction_type
      @amount = amount
      @recipient_wallet = recipient_wallet
      @errors = ActiveModel::Errors.new(self)
    end
  
    def create_transaction
        #do not process transaction when amount is less than or equals to 0
        if @amount <= 0
            @errors.add(:base, "Amount should be greater than 0")
            return false
        end

        # Check for sufficient funds for 'debit' or 'transfer' transactions
        if debit_or_transfer? && @wallet.balance < @amount
            @errors.add(:base, "Insufficient funds")
            return false
        end
    
        # Ensure a recipient wallet is provided for 'transfer' transactions
        if @transaction_type == "transfer" && !@recipient_wallet
            @errors.add(:base, "Recipient wallet is required")
            return false
        end

        #can not make transfer funds between same wallet
        if @recipient_wallet&.id == @wallet.id
            @errors.add(:base, "Recipient wallet and wallet must be different")
            return false
        end
    
        # If all validations pass, proceed to process the transaction
        process_transaction
    end
  
    private
  
    # Check if the transaction type is 'debit' or 'transfer'
    def debit_or_transfer?
      @transaction_type == "debit" || @transaction_type == "transfer"
    end
  
    # Process the transaction within an ActiveRecord transaction block
    def process_transaction
      ActiveRecord::Base.transaction do
        # Create the main transaction record and assign it to the instance variable `@transaction`
        @transaction = @wallet.transactions.create!(
          transaction_type: @transaction_type,
          amount: @amount,
          status: :pending,
          recipient_wallet_id: @recipient_wallet&.id
        )
        
        # If it's a transfer, also create the transaction for the recipient wallet
        if @transaction_type == 'transfer' && @recipient_wallet
          @recipient_transaction = @recipient_wallet.transactions.create!(
            transaction_type: :credit,
            amount: @amount,
            status: :pending,
            recipient_wallet_id: @wallet.id
          )
        end
  
        # Update the wallet balances based on the transaction type
        if @transaction_type == 'credit'
          @wallet.update!(balance: @wallet.balance + @amount)
        elsif @transaction_type == 'debit'
          @wallet.update!(balance: @wallet.balance - @amount)
        elsif @transaction_type == 'transfer'
          # Handle the transfer of funds between two wallets
          @wallet.update!(balance: @wallet.balance - @amount)
          @recipient_wallet.update!(balance: @recipient_wallet.balance + @amount)
        end
  
        # After all updates, mark the transaction as 'completed'
        @transaction.update!(status: :completed)
        
        if @transaction_type == "transfer"
            @recipient_transaction.update!(status: :completed)
        end

        # Return the processed transaction
        @transaction
      end
    rescue ActiveRecord::RecordInvalid => e
      # Handle errors if an exception occurs
      @errors.add(:base, e.message)
      false
    end
  end
  