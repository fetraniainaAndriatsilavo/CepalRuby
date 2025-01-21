require 'swagger_helper'

RSpec.describe 'Wallet Transactions API', type: :request do
  # GET /wallets/:wallet_id/transactions
  path '/wallets/{wallet_id}/transactions' do
    get 'Retrieves all transactions for a wallet' do
      tags 'Wallet Transactions'
      produces 'application/json'
      parameter name: :wallet_id, in: :path, type: :integer, description: 'ID of the wallet'

      response '200', 'transactions found' do
        let(:wallet) { create(:wallet) }
        let!(:transaction1) { create(:transaction, wallet: wallet) }
        let!(:transaction2) { create(:transaction, wallet: wallet) }
        let(:wallet_id) { wallet.id }

        run_test!
      end

      response '404', 'wallet not found' do
        let(:wallet_id) { 'nonexistent_wallet_id' }
        run_test!
      end
    end
  end
end
