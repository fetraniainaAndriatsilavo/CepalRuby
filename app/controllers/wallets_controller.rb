class WalletsController < ApplicationController
  def create
    wallet = Wallet.new(wallet_params)
    if wallet.save
      render json: wallet, status: :created
    else
      render json: { errors: wallet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    wallet = Wallet.find(params[:id])
    render json: wallet
  end

  private

  def wallet_params
    params.require(:wallet).permit(:user_id)
  end
end
