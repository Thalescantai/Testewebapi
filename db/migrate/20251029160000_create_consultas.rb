class CreateConsultas < ActiveRecord::Migration[7.2]
  def change
    create_table :consultas do |t|
      t.integer :medico_id
      t.datetime :data_hora
      t.string :tipo
      t.text :anamnese
      t.text :diagnostico

      t.timestamps
    end
  end
end
