class AddTransactionsTable < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :merchant_id
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.datetime :date
      t.integer :auth_code
      t.string :status
      t.timestamps
    end
  end
end