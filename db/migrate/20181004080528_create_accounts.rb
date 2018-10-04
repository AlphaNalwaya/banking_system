class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :account_no
      t.integer :balance
      t.string :category
      t.references :bank, index: true, foregin_key: true
      t.references :user, index: true, foregin_key: true

      t.timestamps
    end
  end
end
