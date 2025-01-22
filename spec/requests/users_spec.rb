require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/users' do
    # POST /users
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string, format: :email },
          password: { type: :string }
        },
        required: %w[name email password]
      }

      response '201', 'user created' do
        let(:user) { { name: 'John Doe', email: 'john.doe@example.com', password: 'password123' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: '', email: 'invalid', password: '' } }
        run_test!
      end
    end

    # GET /users
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'users found' do
        run_test!
      end
    end
  end

  path '/users/{id}' do
    # GET /users/:id
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the user'

      response '200', 'user found' do
        let(:id) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password123').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 0 }
        run_test!
      end
    end
  end
end
