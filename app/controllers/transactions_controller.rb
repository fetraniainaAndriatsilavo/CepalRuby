class TransactionsController < ApplicationController
  # Before actions
  before_action :set_wallet, only: [:create]
  # Ensures the wallet is set before creating a transaction

  # POST /transactions
  def create
    # Initialize the transaction service with necessary parameters
    transaction_service = TransactionService.new(
      @wallet,
      transaction_params[:transaction_type],
      transaction_params[:amount],
      recipient_wallet
    )

    # Attempt to create the transaction
    if transaction_service.create_transaction
      render json: transaction_service.transaction, status: :created
      # Respond with the created transaction if successful
    else
      render json: { errors: transaction_service.errors.full_messages }, status: :unprocessable_entity
      # Respond with validation errors if creation fails
    end
  end

  # GET /transactions/:id
  def show
    render json: @transaction
    # Display the transaction details in JSON format
  end

  private

  # Strong parameters for transaction creation
  def transaction_params
    params.require(:transaction).permit(:wallet_id, :transaction_type, :amount, :recipient_wallet_id)
    # Ensures only the allowed parameters are accepted
  end

  # Find a transaction by ID
  def set_transaction
    @transaction = Transaction.find(params[:id])
    # Sets the transaction instance variable for the show action
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Transaction not found' }, status: :not_found
    # Responds with an error message if the transaction is not found
  end

  # Find the wallet for the current request
  def set_wallet
    @wallet = Wallet.find_by(id: params[:wallet_id])
    # Sets the wallet instance variable for the create action
    render json: { error: 'Wallet not found' }, status: :not_found unless @wallet
    # Responds with an error if the wallet is not found
  end

  # Find the recipient wallet if provided
  def recipient_wallet
    if params[:recipient_wallet_id]
      Wallet.find_by(id: params[:recipient_wallet_id])
      # Looks up the recipient wallet by its ID
    end
  end
end
