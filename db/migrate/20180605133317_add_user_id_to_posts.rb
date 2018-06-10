class AddUserIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :user_name, unique: true
    add_reference :posts, :user, foreign_key: true
  end
end
