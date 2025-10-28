class Exame < ApplicationRecord
  STATUS_LABELS = {
    "pendente" => "Pendente",
    "agendado" => "Agendado",
    "realizado" => "Realizado",
    "anexado" => "Anexado"
  }.freeze

  enum status: STATUS_LABELS.transform_keys(&:to_sym), _prefix: true

  belongs_to :consulta, inverse_of: :exames

  validates :status, inclusion: { in: statuses.keys }

  delegate :medico, to: :consulta, allow_nil: true

  def self.status_options_for_select
    STATUS_LABELS.map { |value, label| [label, value] }
  end
end
