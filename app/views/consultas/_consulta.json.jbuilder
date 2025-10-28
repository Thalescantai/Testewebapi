json.extract! consulta, :id, :atendimento_id, :medico_id, :data_hora, :tipo, :anamnese, :diagnostico, :created_at, :updated_at
json.url consulta_url(consulta, format: :json)
