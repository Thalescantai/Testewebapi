class Paciente < ApplicationRecord
  # Campos que podem ser pesquisados pelo Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[
      nome
      nome_social
      cpf
      sexo
      data_nascimento
      celular
      email
      horario
      observacao
      created_at
      updated_at
    ]
  end
end
