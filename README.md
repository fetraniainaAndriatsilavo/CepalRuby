# CepalRuby
Test Ruby On Rails

This restapi use SQLite3

# Start the server with:

$ rails db:migrate
$ rails s -p 3001

# Using postman here is all Endpoints API

# post user [http://127.0.0.1:3001/users]

{
  "user": {
    "name": "Kilian James",
    "email": "kilianjames@gmail.com",
    "password": "password123"
  }
}

{
  "user": {
    "name": "David becam",
    "email": "david.becam@yahoo.com",
    "password": "password123"
  }
}

# post wallet {http://127.0.0.1:3001/wallets}

{
  "wallet": {
    "user_id": 1
  }
}


{
  "wallet": {
    "user_id": 2
  }
}

# get one wallete

http://127.0.0.1:3001/wallets/:id

# post transaction
== CREDIT : to credit 200€ on wallet 1
{
  "transaction": {
    "wallet_id": "1",  
    "amount": 100.0,  
    "transaction_type": "credit"
  }
}

== DEBIT : to debit 100€ on wallet 1
{
  "transaction": {
    "wallet_id": "1",  
    "amount": 100.0,  
    "transaction_type": "debit"
  }
}

== TRANSFER : to transfer 50€ form wallet 1 to wallet 2
{
  "transaction": {
    "wallet_id": "1",  
    "recipient_wallet_id": "2",  
    "amount": 50,  
    "transaction_type": "transfer"
  }
}
# get one transaction

http://127.0.0.1:3001/transactions/:id

# get one wallet with his transactions

http://127.0.0.1:3001/wallets/:wallet_id/transactions
