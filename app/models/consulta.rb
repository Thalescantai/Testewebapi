class Consulta < ApplicationRecord
  belongs_to :paciente
  has_many :exames, dependent: :destroy
  belongs_to :medico, class_name: "Profissional", optional: true, inverse_of: :consultas

  enum status: { agendado: 0, atendido: 1, faltou: 2, finalizado: 3 }

  after_initialize :set_default_status, if: :new_record?

  accepts_nested_attributes_for :exames, allow_destroy: true, reject_if: :all_blank

  validates :data_hora, presence: true
  validates :paciente, presence: true
  validates :status, presence: true

  def display_label
    parts = []
    parts << data_hora.strftime("%d/%m/%Y %H:%M") if data_hora.present?
    parts << tipo if tipo.present?
    parts << "Dr(a). #{medico.nome}" if medico&.nome.present?
    parts.compact.join(" - ")
  end

  private

  def set_default_status
    self.status ||= :agendado
  end
end
