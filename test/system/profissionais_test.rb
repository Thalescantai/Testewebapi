require "application_system_test_case"

class ProfissionaisTest < ApplicationSystemTestCase
  setup do
    @profissional = profissionais(:one)
  end

  test "visiting the index" do
    visit profissionais_url
    assert_selector "h1", text: "Profissionais"
  end

  test "should create profissional" do
    visit profissionais_url
    click_on "Novo profissional"

    fill_in "Cargo", with: @profissional.cargo
    fill_in "Cpf", with: @profissional.cpf
    fill_in "Email", with: @profissional.email
    fill_in "Nome", with: @profissional.nome
    fill_in "Telefone", with: @profissional.telefone
    click_on "Create Profissional"

    assert_text "Profissional was successfully created"
    click_on "Voltar para profissionais"
  end

  test "should update Profissional" do
    visit profissional_url(@profissional)
    click_on "Editar profissional", match: :first

    fill_in "Cargo", with: @profissional.cargo
    fill_in "Cpf", with: @profissional.cpf
    fill_in "Email", with: @profissional.email
    fill_in "Nome", with: @profissional.nome
    fill_in "Telefone", with: @profissional.telefone
    click_on "Update Profissional"

    assert_text "Profissional was successfully updated"
    click_on "Voltar para profissionais"
  end

  test "should destroy Profissional" do
    visit profissional_url(@profissional)
    click_on "Excluir profissional", match: :first

    assert_text "Profissional was successfully destroyed"
  end
end
