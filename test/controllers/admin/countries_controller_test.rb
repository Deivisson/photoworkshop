require 'test_helper'

class Admin::CountriesControllerTest < ActionController::TestCase
  setup do
    @admin_country = admin_countries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_countries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_country" do
    assert_difference('Admin::Country.count') do
      post :create, admin_country: { name: @admin_country.name }
    end

    assert_redirected_to admin_country_path(assigns(:admin_country))
  end

  test "should show admin_country" do
    get :show, id: @admin_country
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_country
    assert_response :success
  end

  test "should update admin_country" do
    patch :update, id: @admin_country, admin_country: { name: @admin_country.name }
    assert_redirected_to admin_country_path(assigns(:admin_country))
  end

  test "should destroy admin_country" do
    assert_difference('Admin::Country.count', -1) do
      delete :destroy, id: @admin_country
    end

    assert_redirected_to admin_countries_path
  end
end
