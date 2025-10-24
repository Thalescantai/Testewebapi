require "test_helper"

class EnderecoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get endereco_index_url
    assert_response :success
  end

  test "should get show" do
    get endereco_show_url
    assert_response :success
  end

  test "should get new" do
    get endereco_new_url
    assert_response :success
  end

  test "should get edit" do
    get endereco_edit_url
    assert_response :success
  end

  test "should get create" do
    get endereco_create_url
    assert_response :success
  end

  test "should get update" do
    get endereco_update_url
    assert_response :success
  end

  test "should get destroy" do
    get endereco_destroy_url
    assert_response :success
  end
end
