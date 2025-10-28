class FixExamesForeignKey < ActiveRecord::Migration[7.2]
  def change
    if foreign_key_exists?(:exames, to_table: :consulta)
      remove_foreign_key :exames, to_table: :consulta
    elsif foreign_key_exists?(:exames, column: :consulta_id)
      remove_foreign_key :exames, column: :consulta_id
    end
    add_foreign_key :exames, :consultas, column: :consulta_id
  end
end
