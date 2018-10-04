class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :phone_no
      t.references :bank, index: true, foregin_key: true

      t.timestamps
    end
  end
end
