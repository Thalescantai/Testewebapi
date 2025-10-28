class Consulta < ApplicationRecord

  has_many :exames, dependent: :destroy
  belongs_to :medico, class_name: "Profissional", optional: true, inverse_of: :consultas

  validates :data_hora, presence: true

  def display_label
    parts = []
    parts << data_hora.strftime("%d/%m/%Y %H:%M") if data_hora.present?
    parts << tipo if tipo.present?
    parts << "Dr(a). #{medico.nome}" if medico&.nome.present?
    parts.compact.join(" - ")
  end
end
