class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :cpf, null: false
      t.string :password_digest, null: false
      t.string :remember_token_digest
      t.datetime :last_login_at

      t.timestamps
    end
    add_index :users, :cpf, unique: true
  end
end
