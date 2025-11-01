class MateriaisController < ApplicationController
  before_action :set_consulta, only: :por_consulta

  def index
    @consultas_para_materiais = Consulta.joins(:materials)
                                        .includes(:paciente, :medico, :materials)
                                        .distinct
                                        .order(updated_at: :desc)
  end

  def por_consulta
    @materiais = @consulta.materials.order(:created_at)
  end

  private

  def set_consulta
    @consulta = Consulta.includes(:paciente, :medico, :materials).find(params[:consulta_id])
  end
end
