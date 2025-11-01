class Exame < ApplicationRecord
  STATUS_LABELS = {
    "pendente" => "Pendente",
    "agendado" => "Agendado",
    "realizado" => "Realizado",
    "anexado" => "Anexado"
  }.freeze

  enum status: STATUS_LABELS.transform_keys(&:to_sym), _prefix: true

  belongs_to :consulta, inverse_of: :exames
  has_one_attached :arquivo_resultado

  accepts_nested_attributes_for :consulta, update_only: true

  validates :status, inclusion: { in: statuses.keys }, allow_blank: true
  validates :observacao_exame, length: { maximum: 1000 }, allow_blank: true

  delegate :medico, to: :consulta, allow_nil: true

  def self.status_options_for_select
    STATUS_LABELS.map { |value, label| [label, value] }
  end
end
