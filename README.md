# CepalRuby
Test Ruby On Rails

This restapi use SQLite3

# Start the server with:
ensures that your database schema is up
```bash
$ rails db:migrate
```

starts your Rails application and makes it accessible at http://localhost:3001
```bash
$ rails s -p 3001
```

runs the RSpec tests
```bash
$ bundle exec rspec
```

check Ruby code for any issues related to style
```bash
$ bundle exec rubocop
```

# Here are all the API endpoints, tested using Postman

# post user [http://127.0.0.1:3001/users]
try to create 2 users
```json
{
  "user": {
    "name": "Kilian James",
    "email": "kilianjames@gmail.com",
    "password": "password123"
  }
}
```

```json
{
  "user": {
    "name": "David becam",
    "email": "david.becam@yahoo.com",
    "password": "password123"
  }
}
```

# post wallet {http://127.0.0.1:3001/wallets}
create one wallet for each user
```json
{
  "wallet": {
    "user_id": 1
  }
}
```

```json
{
  "wallet": {
    "user_id": 2
  }
}
```

# get one wallet

http://127.0.0.1:3001/wallets/:id

# post transaction

Attempt to send/transfer money between the two wallets we created earlier

== CREDIT : to credit 200€ on wallet 1
```json
{
  "transaction": {
    "wallet_id": "1",  
    "amount": 200.0,  
    "transaction_type": "credit"
  }
}
```

== DEBIT : to debit 100€ on wallet 1
```json
{
  "transaction": {
    "wallet_id": "1",  
    "amount": 100.0,  
    "transaction_type": "debit"
  }
}
```

== TRANSFER : to transfer 50€ form wallet 1 to wallet 2
```json
{
  "transaction": {
    "wallet_id": "1",  
    "recipient_wallet_id": "2",  
    "amount": 50,  
    "transaction_type": "transfer"
  }
}
```

# get one transaction

```
http://127.0.0.1:3001/transactions/:id
```

# get one wallet with his transactions
```
http://127.0.0.1:3001/wallets/:wallet_id/transactions
```

# REF
![Alt text](https://github.com/RFaly/CepalRuby/blob/main/public/Screenshot%202025-01-18%20123311.png?raw=true)
