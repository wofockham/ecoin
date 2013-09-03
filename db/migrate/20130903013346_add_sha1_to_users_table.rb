class AddSha1ToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :sha1, :text



  end
end


