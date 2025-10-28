class CreateExames < ActiveRecord::Migration[7.2]
  def change
    create_table :exames do |t|
      t.references :consulta, null: false, foreign_key: { to_table: :consultas }
      t.string :tipo_exame
      t.date :data_solicitacao
      t.date :data_marcada
      t.date :data_realizada
      t.string :status, default: "pendente"
      t.text :observacoes

      t.timestamps
    end
  end
end
