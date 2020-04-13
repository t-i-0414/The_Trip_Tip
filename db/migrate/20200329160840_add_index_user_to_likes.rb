# frozen_string_literal: true

class AddIndexUserToLikes < ActiveRecord::Migration[6.0]
  def change
    add_index :likes, :user_id
    add_index :likes, :micropost_id
    add_index :likes, [:user_id, :micropost_id], unique: true
  end
end
