class TransactionsController < ApplicationController
  before_action :set_wallet, only: [:create]
  # POST /transactions
  def create
    transaction_service = TransactionService.new(
        @wallet,
        transaction_params[:transaction_type],
        transaction_params[:amount],
        recipient_wallet
      )
  
    if transaction_service.create_transaction
        render json: transaction_service.transaction, status: :created
    else
        render json: { errors: transaction_service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /transactions/:id
  def show
    render json: @transaction
  end

  private

  def transaction_params
    params.require(:transaction).permit(:wallet_id, :transaction_type, :amount, :recipient_wallet_id)
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Transaction not found' }, status: :not_found
  end

  def set_wallet
    @wallet = Wallet.find_by(id: params[:wallet_id])
    render json: { error: 'Wallet not found' }, status: :not_found unless @wallet
  end

  def recipient_wallet
    if params[:recipient_wallet_id]
      Wallet.find_by(id: params[:recipient_wallet_id])
    end
  end
end
