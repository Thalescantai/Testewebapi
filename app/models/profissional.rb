class Profissional < ApplicationRecord
  enum cargo: {
    medico: "medico",
    recepcionista: "recepcionista",
    enfermeiro: "enfermeiro",
    administrador: "administrador"
  }, _prefix: true

  has_many :consultas, foreign_key: :medico_id, inverse_of: :medico, dependent: :nullify

  validates :nome, presence: true
  validates :cargo, presence: true, inclusion: { in: cargos.keys }
  validates :email, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: { allow_blank: true, case_sensitive: false }
  validates :cpf, allow_blank: true, uniqueness: true

  def self.role_options_for_select
    ROLE_LABELS.map { |value, label| [label, value] }
  end

  private

  def normalize_email
    self.email = email.downcase if email.present?
  end
end
  ROLE_LABELS = {
    "medico" => "Médico",
    "recepcionista" => "Recepcionista",
    "enfermeiro" => "Enfermeiro",
    "administrador" => "Administrador"
  }.freeze
  before_save :normalize_email
