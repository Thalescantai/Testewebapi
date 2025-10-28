json.extract! atendimento, :id, :paciente_id, :tipo_paciente, :data_entrada, :encaminhamento, :status, :observacoes, :created_at, :updated_at
json.url atendimento_url(atendimento, format: :json)
