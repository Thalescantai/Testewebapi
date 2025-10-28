class Paciente < ApplicationRecord
  has_one :endereco, dependent: :destroy
  has_many :atendimentos, dependent: :destroy
  accepts_nested_attributes_for :endereco

  # Campos que podem ser pesquisados pelo Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[
      nome cpf sexo data_nascimento celular email nome_social horario observacao
      cartao_sus profissao rg org_exp escolaridade raca nacionalidade
      estado_civil naturalidade nome_mae created_at updated_at
    ]
  end

end
