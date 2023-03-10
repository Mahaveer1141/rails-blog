class AddOnDeleteCascade < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :posts, :users
    add_foreign_key :posts, :users, on_delete: :cascade
    remove_foreign_key :comments, :posts
    add_foreign_key :comments, :posts, on_delete: :cascade
    remove_foreign_key :votes, :posts
    add_foreign_key :votes, :posts, on_delete: :cascade
  end
end
