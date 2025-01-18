# app/controllers/transactions_controller.rb
class TransactionsController < ApplicationController
    def create
      @transaction = Transaction.new(transaction_params)
      @transaction.status = 'pending'
  
      if @transaction.transaction_type == 'credit'
        @transaction = CreditService.new(@transaction.wallet, @transaction.amount).process_credit
      elsif @transaction.transaction_type == 'debit'
        @transaction = DebitService.new(@transaction.wallet, @transaction.amount).process_debit
      elsif @transaction.transaction_type == 'transfer'
        if TransferService.new(@transaction).process_transfer
          @transaction.status = 'completed'
        else
          @transaction.status = 'failed'
        end
      else
        @transaction.status = 'failed'
      end
  
      if @transaction.save
        render json: @transaction, status: :created
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    end

    def index
        @wallet = Wallet.find(params[:wallet_id])
        @transactions = @wallet.transactions
        render json: @transactions, status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: "Transaction not found" }, status: :not_found
    end

    def show
        @transaction = Transaction.find(params[:id])
    
        render json: @transaction, status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: "Transaction not found" }, status: :not_found
    end
    
    private
  
    def transaction_params
      params.require(:transaction).permit(:wallet_id, :recipient_wallet_id, :amount, :transaction_type)
    end
  end
  