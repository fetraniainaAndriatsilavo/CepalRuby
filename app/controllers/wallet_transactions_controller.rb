class WalletTransactionsController < ApplicationController
    before_action :set_wallet

    # GET /wallets/:id/transactions
    def index
      transactions = @wallet.transactions.order(created_at: :desc)
      render json: transactions
    end
  
    private
  
    def set_wallet
      @wallet = Wallet.includes(:transactions).find(params[:wallet_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Wallet not found' }, status: :not_found
    end
end
