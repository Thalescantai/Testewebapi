class AddFieldsToPacientes < ActiveRecord::Migration[7.2]
  def change
    add_column :pacientes, :sexo, :string
    add_column :pacientes, :data_nascimento, :date
    add_column :pacientes, :celular, :string
    add_column :pacientes, :email, :string
    add_column :pacientes, :nome_social, :string
    add_column :pacientes, :horario, :string
    add_column :pacientes, :observacao, :text
  end
end
