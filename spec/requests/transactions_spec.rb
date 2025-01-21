require 'swagger_helper'

RSpec.describe 'Transactions API', type: :request do
  # POST /transactions
  path '/transactions' do
    post 'Creates a new transaction' do
      tags 'Transactions'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :transaction, in: :body, schema: {
        type: :object,
        properties: {
          wallet_id: { type: :integer },
          transaction_type: { type: :string, enum: ['credit', 'debit', 'transfer'] },
          amount: { type: :number },
          recipient_wallet_id: { type: :integer }
        },
        required: %w[wallet_id transaction_type amount]
      }

      response '201', 'transaction created' do
        let(:transaction) { { wallet_id: 1, transaction_type: 'credit', amount: 100, recipient_wallet_id: 2 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:transaction) { { wallet_id: 1, transaction_type: 'invalid_type', amount: 100 } }
        run_test!
      end
    end
  end

  # GET /transactions/:id
  path '/transactions/{id}' do
    get 'Retrieves a transaction' do
      tags 'Transactions'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the transaction'

      response '200', 'transaction found' do
        let(:transaction) { create(:transaction) }
        let(:id) { transaction.id }
        run_test!
      end

      response '404', 'transaction not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end
    end
  end
end
