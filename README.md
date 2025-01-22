# Cepal API

The Cepal API provides a backend for managing wallets and transactions. It allows users to create wallets, manage transactions, and view transaction history. The API is built with Ruby on Rails and provides endpoints to facilitate interaction between users and their wallets.

## Features

- **Wallet Management**: Allows users to create a wallet and associate it with a user ID.
- **Transactions**: Supports transaction creation and retrieval for wallets, enabling users to transfer funds between different wallets.
- **Transaction History**: Users can view all transactions associated with their wallet in descending order of creation.

## API Endpoints

### Wallets

- **POST /wallets**: Create a new wallet for a user.
- **GET /wallets/{id}**: Retrieve the details of a specific wallet by its ID.

### Wallet Transactions

- **GET /wallets/{wallet_id}/transactions**: Retrieve all transactions for a wallet, ordered by the most recent.

## Installation
- gem install bundler
- bundle install


### Prerequisites

1. **Ruby**: The project requires Ruby 3.2.6 or higher.
2. **Rails**: The project is built using Rails 7.x.
3. **Database**: SQLite is used as the default database.

# Run
- bundle exec rails s

#Generate Swagger Documentation
- bundle exec rails rswag:specs:swaggerize

# Run Tests
- bundle exec rspec
