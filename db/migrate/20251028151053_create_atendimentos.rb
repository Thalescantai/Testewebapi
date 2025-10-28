class CreateAtendimentos < ActiveRecord::Migration[7.2]
  def change
    create_table :atendimentos do |t|
      t.references :paciente, null: false, foreign_key: true
      t.string :tipo_paciente
      t.date :data_entrada
      t.string :encaminhamento
      t.string :status
      t.text :observacoes

      t.timestamps
    end
  end
end
