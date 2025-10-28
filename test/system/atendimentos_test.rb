require "application_system_test_case"

class AtendimentosTest < ApplicationSystemTestCase
  setup do
    @atendimento = atendimentos(:one)
  end

  test "visiting the index" do
    visit atendimentos_url
    assert_selector "h1", text: "Atendimentos"
  end

  test "should create atendimento" do
    visit atendimentos_url
    click_on "New atendimento"

    fill_in "Data entrada", with: @atendimento.data_entrada
    fill_in "Encaminhamento", with: @atendimento.encaminhamento
    fill_in "Observacoes", with: @atendimento.observacoes
    fill_in "Paciente", with: @atendimento.paciente_id
    fill_in "Status", with: @atendimento.status
    fill_in "Tipo paciente", with: @atendimento.tipo_paciente
    click_on "Create Atendimento"

    assert_text "Atendimento was successfully created"
    click_on "Back"
  end

  test "should update Atendimento" do
    visit atendimento_url(@atendimento)
    click_on "Edit this atendimento", match: :first

    fill_in "Data entrada", with: @atendimento.data_entrada
    fill_in "Encaminhamento", with: @atendimento.encaminhamento
    fill_in "Observacoes", with: @atendimento.observacoes
    fill_in "Paciente", with: @atendimento.paciente_id
    fill_in "Status", with: @atendimento.status
    fill_in "Tipo paciente", with: @atendimento.tipo_paciente
    click_on "Update Atendimento"

    assert_text "Atendimento was successfully updated"
    click_on "Back"
  end

  test "should destroy Atendimento" do
    visit atendimento_url(@atendimento)
    click_on "Destroy this atendimento", match: :first

    assert_text "Atendimento was successfully destroyed"
  end
end
