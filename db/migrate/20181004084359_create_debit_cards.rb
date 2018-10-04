class CreateDebitCards < ActiveRecord::Migration[5.2]
  def change
    create_table :debit_cards do |t|
      t.integer :card_no
      t.date :expiry_date
      t.date :issue_date
      t.integer :pin_no
      t.references :account, index: true, foregin_key: true

      t.timestamps
    end
  end
end
