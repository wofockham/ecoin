class AddUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone
      t.timestamps
    end
  end
end