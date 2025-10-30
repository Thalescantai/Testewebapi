class RemoveAnamneseFromConsultas < ActiveRecord::Migration[7.2]
  def change
    remove_column :consultas, :anamnese, :text
  end
end
