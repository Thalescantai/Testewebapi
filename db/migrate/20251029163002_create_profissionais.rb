class CreateProfissionais < ActiveRecord::Migration[7.2]
  def change
    create_table :profissionais do |t|
      t.string :nome, null: false
      t.string :email
      t.string :telefone
      t.string :cpf
      t.string :cargo, null: false

      t.timestamps
    end

    add_index :profissionais, :email, unique: true
    add_index :profissionais, :cpf, unique: true
  end
end
