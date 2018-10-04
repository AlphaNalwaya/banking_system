class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.references :account, foreign_key: true
      t.references :debit_card, index: true, foreign_key: true

      t.timestamps
    end
  end
end