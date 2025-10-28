class Endereco < ApplicationRecord
  belongs_to :paciente, optional: true
end
