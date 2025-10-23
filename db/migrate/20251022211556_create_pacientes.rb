class CreatePacientes < ActiveRecord::Migration[7.2]
  def change
    create_table :pacientes do |t|
      t.string :nome
      t.string :cpf

      t.timestamps
    end
  end
end
