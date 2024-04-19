require "test_helper"

class EstablishmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @establishment = establishments(:one)
  end

  test "should get index" do
    get establishments_url
    assert_response :success
  end

  test "should get new is sucess" do
    get new_establishment_url
    assert_response :success
  end

  test "should create establishment" do
    assert_difference("Establishment.count") do
      post establishments_url, params: { establishment: { city: @establishment.city, country: @establishment.country, opening_hours: @establishment.opening_hours, state: @establishment.state, street: @establishment.street, zip_code: @establishment.zip_code } }
    end

    assert_redirected_to establishment_url(Establishment.last)
  end

  test "should show establishment" do
    get establishment_url(@establishment)
    assert_response :success
  end

  test "should get edit" do
    get edit_establishment_url(@establishment)
    assert_response :success
  end

  test "should update establishment" do
    patch establishment_url(@establishment), params: { establishment: { city: @establishment.city, country: @establishment.country, opening_hours: @establishment.opening_hours, state: @establishment.state, street: @establishment.street, zip_code: @establishment.zip_code } }
    assert_redirected_to establishment_url(@establishment)
  end

  test "should destroy establishment" do
    assert_difference("Establishment.count", -1) do
      delete establishment_url(@establishment)
    end

    assert_redirected_to establishments_url
  end
end
