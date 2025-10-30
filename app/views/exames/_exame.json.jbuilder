json.extract! exame, :id, :consulta_id, :nome_exame, :data_exame, :status, :observacao_exame, :data_realizacao, :profissional_realizou_exame, :created_at, :updated_at
json.status_label Exame::STATUS_LABELS[exame.status]
json.consulta_label exame.consulta&.display_label
if exame.arquivo_resultado.attached?
  json.arquivo_resultado_url url_for(exame.arquivo_resultado)
end
json.url exame_url(exame, format: :json)
