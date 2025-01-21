require 'swagger_helper'

RSpec.describe 'Wallets API', type: :request do
  # POST /wallets
  path '/wallets' do
    post 'Creates a new wallet' do
      tags 'Wallets'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :wallet, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer }
        },
        required: ['user_id']
      }

      response '201', 'wallet created' do
        let(:wallet) { { user_id: 1 } }
        run_test!
      end

      response '422', 'wallet already exists' do
        let!(:existing_wallet) { create(:wallet, user_id: 1) }
        let(:wallet) { { user_id: 1 } }
        run_test!
      end
    end
  end

  # GET /wallets/:id
  path '/wallets/{id}' do
    get 'Retrieves a wallet' do
      tags 'Wallets'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the wallet'

      response '200', 'wallet found' do
        let(:wallet) { create(:wallet, user_id: 1) }
        let(:id) { wallet.id }
        run_test!
      end

      response '404', 'wallet not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end
    end
  end
end
