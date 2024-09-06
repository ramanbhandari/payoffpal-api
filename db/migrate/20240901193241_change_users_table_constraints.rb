# frozen_string_literal: true

class ChangeUsersTableConstraints < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false

    add_index :users, :email, unique: true
  end
end
