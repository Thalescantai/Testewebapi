class AddMedicoToConsultas < ActiveRecord::Migration[7.2]
  def change
    add_index :consultas, :medico_id
    add_foreign_key :consultas, :profissionais, column: :medico_id
  end
end
