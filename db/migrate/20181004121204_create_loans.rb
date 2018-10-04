class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.string :loan_type
      t.float :amount
      t.integer :interest_rate
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end