class AddCoachRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :coach_role, :boolean, default: false
  end
end
