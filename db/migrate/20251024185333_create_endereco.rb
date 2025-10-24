class CreateEndereco < ActiveRecord::Migration[7.2]
  def change
    create_table :enderecos do |t|
      t.string :rua
      t.string :numero
      t.string :bairro
      t.string :cep
      t.string :cidade
      t.string :complemento
      t.string :logradouro

      t.timestamps
    end
  end
end
