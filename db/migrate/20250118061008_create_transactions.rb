class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.string :transaction_type
      t.decimal :amount
      t.integer :recipient_wallet_id
      t.string :status

      t.timestamps
    end
  end
end
