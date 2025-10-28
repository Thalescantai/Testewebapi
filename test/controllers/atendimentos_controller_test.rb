require "test_helper"

class AtendimentosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @atendimento = atendimentos(:one)
  end

  test "should get index" do
    get atendimentos_url
    assert_response :success
  end

  test "should get new" do
    get new_atendimento_url
    assert_response :success
  end

  test "should create atendimento" do
    assert_difference("Atendimento.count") do
      post atendimentos_url, params: { atendimento: { data_entrada: @atendimento.data_entrada, encaminhamento: @atendimento.encaminhamento, observacoes: @atendimento.observacoes, paciente_id: @atendimento.paciente_id, status: @atendimento.status, tipo_paciente: @atendimento.tipo_paciente } }
    end

    assert_redirected_to atendimento_url(Atendimento.last)
  end

  test "should show atendimento" do
    get atendimento_url(@atendimento)
    assert_response :success
  end

  test "should get edit" do
    get edit_atendimento_url(@atendimento)
    assert_response :success
  end

  test "should update atendimento" do
    patch atendimento_url(@atendimento), params: { atendimento: { data_entrada: @atendimento.data_entrada, encaminhamento: @atendimento.encaminhamento, observacoes: @atendimento.observacoes, paciente_id: @atendimento.paciente_id, status: @atendimento.status, tipo_paciente: @atendimento.tipo_paciente } }
    assert_redirected_to atendimento_url(@atendimento)
  end

  test "should destroy atendimento" do
    assert_difference("Atendimento.count", -1) do
      delete atendimento_url(@atendimento)
    end

    assert_redirected_to atendimentos_url
  end
end
