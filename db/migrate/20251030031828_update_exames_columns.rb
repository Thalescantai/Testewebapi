class UpdateExamesColumns < ActiveRecord::Migration[7.2]
  def change
    change_table :exames, bulk: true do |t|
      t.rename :tipo_exame, :nome_exame if column_exists?(:exames, :tipo_exame)
      t.rename :data_marcada, :data_exame if column_exists?(:exames, :data_marcada)
      t.rename :observacoes, :observacao_exame if column_exists?(:exames, :observacoes)
    end

    remove_column :exames, :data_solicitacao, :date if column_exists?(:exames, :data_solicitacao)
    remove_column :exames, :data_realizada, :date if column_exists?(:exames, :data_realizada)
  end
end
