class AddRealizacaoFieldsToExames < ActiveRecord::Migration[7.2]
  def change
    add_column :exames, :data_realizacao, :datetime
    add_column :exames, :profissional_realizou_exame, :string
  end
end
