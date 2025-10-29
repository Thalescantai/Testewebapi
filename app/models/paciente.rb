class Paciente < ApplicationRecord
  has_one :endereco, dependent: :destroy
  accepts_nested_attributes_for :endereco

  before_validation :normalize_cpf
  before_validation :normalize_celular

  # Campos que podem ser pesquisados pelo Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[
      nome cpf sexo data_nascimento celular email nome_social horario observacao
      cartao_sus profissao rg org_exp escolaridade raca nacionalidade
      estado_civil naturalidade nome_mae created_at updated_at
    ]
  end

  private

  def normalize_cpf
    self.cpf = cpf.gsub(/\D/, "") if cpf.present?
  end

  def normalize_celular
    self.celular = celular.gsub(/\D/, "") if celular.present?
  end
end
