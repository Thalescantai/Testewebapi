json.extract! consulta, :id, :medico_id, :data_hora, :tipo, :diagnostico, :created_at, :updated_at
json.medico_nome consulta.medico&.nome
json.exames consulta.exames do |exame|
  json.extract! exame, :id, :nome_exame, :data_exame, :observacao_exame, :status
end
json.url consulta_url(consulta, format: :json)
