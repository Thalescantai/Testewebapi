json.extract! exame, :id, :consulta_id, :tipo_exame, :data_solicitacao, :data_marcada, :data_realizada, :status, :observacoes, :created_at, :updated_at
json.status_label Exame::STATUS_LABELS[exame.status]
json.consulta_label exame.consulta&.display_label
json.url exame_url(exame, format: :json)
