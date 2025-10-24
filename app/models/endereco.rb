class Endereco < ApplicationRecord
  self.table_name = "endereco"
  belongs_to :paciente, optional: true

end
