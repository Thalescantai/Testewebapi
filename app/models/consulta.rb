class Consulta < ApplicationRecord
  self.table_name = "consultas"

  belongs_to :atendimento
  belongs_to :medico, class_name: "Usuario", optional: true

  validates :data_hora, presence: true
end
