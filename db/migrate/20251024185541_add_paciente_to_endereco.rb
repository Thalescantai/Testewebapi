class AddPacienteToEndereco < ActiveRecord::Migration[7.2]
  def change
    add_reference :enderecos, :paciente, null: false, foreign_key: true
  end
end
