class AddPacienteToConsultas < ActiveRecord::Migration[7.2]
  def change
    add_reference :consultas, :paciente, foreign_key: true, null: true
  end
end
