class AddTransactionsTable < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :merchant_id
      t.float :amount
      t.datetime :date
      t.integer :auth_code
      t.string :status
      t.timestamps
    end
  end
end