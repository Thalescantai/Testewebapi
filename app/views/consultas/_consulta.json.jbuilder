json.extract! consulta, :id, :medico_id, :data_hora, :tipo, :anamnese, :diagnostico, :created_at, :updated_at
json.medico_nome consulta.medico&.nome
json.url consulta_url(consulta, format: :json)
