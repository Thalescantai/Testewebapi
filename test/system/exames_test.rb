require "application_system_test_case"

class ExamesTest < ApplicationSystemTestCase
  setup do
    @exame = exames(:one)
  end

  test "visiting the index" do
    visit exames_url
    assert_selector "h1", text: "Fila de exames"
  end

  test "should create exame" do
    visit exames_url
    click_on "Novo exame"

    select @exame.consulta.display_label, from: "Consulta"
    fill_in "Nome do exame", with: @exame.nome_exame
    fill_in "Data do exame", with: @exame.data_exame
    select Exame::STATUS_LABELS[@exame.status], from: "Status"
    fill_in "Observações", with: @exame.observacao_exame
    click_on "Criar exame"

    assert_text "Exame was successfully created"
    click_on "Voltar para exames"
  end

  test "should update Exame" do
    visit exame_url(@exame)
    click_on "Editar exame", match: :first

    fill_in "Nome do exame", with: @exame.nome_exame
    fill_in "Data do exame", with: @exame.data_exame
    select Exame::STATUS_LABELS[@exame.status], from: "Status"
    fill_in "Observações", with: @exame.observacao_exame
    click_on "Atualizar exame"

    assert_text "Exame was successfully updated"
    click_on "Voltar para exames"
  end

  test "should destroy Exame" do
    visit exame_url(@exame)
    click_on "Excluir exame", match: :first

    assert_text "Exame was successfully destroyed"
  end
end
