class AddForeignKeyPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :users, index: true, foreign_key: true, null: false
  end
end
