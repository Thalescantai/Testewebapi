class AddCamposExtrasToPacientes < ActiveRecord::Migration[7.2]
  def change
    add_column :pacientes, :cartao_sus, :string
    add_column :pacientes, :profissao, :string
    add_column :pacientes, :rg, :string
    add_column :pacientes, :org_exp, :string
    add_column :pacientes, :escolaridade, :string
    add_column :pacientes, :raca, :string
    add_column :pacientes, :nacionalidade, :string
    add_column :pacientes, :estado_civil, :string
    add_column :pacientes, :naturalidade, :string
    add_column :pacientes, :nome_mae, :string
  end
end
