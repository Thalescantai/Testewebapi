class Material < ApplicationRecord
  belongs_to :consulta

  delegate :paciente, :medico, to: :consulta, allow_nil: true

  after_initialize :set_defaults, if: :new_record?

  validates :nome_material, presence: true
  validates :data_pedido, presence: true
  validates :quantidade,
            numericality: { only_integer: true, greater_than: 0 }

  private

  def set_defaults
    self.quantidade ||= 1
    self.data_pedido ||= Date.current
  end
end
