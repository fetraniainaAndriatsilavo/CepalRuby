class WalletsController < ApplicationController
  before_action :set_wallet, only: [:show]

  # POST /wallets  create wallet
  def create
    wallet = Wallet.find_by(user_id: params[:user_id])

    if(wallet.present?)
      render json: { error: 'Wallet already exists' }, status: :unprocessable_entity
      return
    end
 
    wallet = Wallet.new(wallet_params)

    if wallet.save
      render json: wallet, status: :created
    else
      render json: { errors: wallet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /wallets/:id
  def show
    render json: @wallet
  end

  private

  def wallet_params
    params.require(:wallet).permit(:user_id)
  end

  def set_wallet
    @wallet = Wallet.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Wallet not found' }, status: :not_found
  end
end
