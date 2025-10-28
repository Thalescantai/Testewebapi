class Atendimento < ApplicationRecord
  belongs_to :paciente
  has_one :consulta, dependent: :destroy

  validates :tipo_paciente, :data_entrada, presence: true
end
