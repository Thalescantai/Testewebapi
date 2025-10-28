class RemoveAtendimentos < ActiveRecord::Migration[7.2]
  def up
    if foreign_key_exists?(:consultas, :atendimentos)
      remove_foreign_key :consultas, :atendimentos
    end

    if column_exists?(:consultas, :atendimento_id)
      remove_column :consultas, :atendimento_id
    end

    drop_table :atendimentos, if_exists: true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
