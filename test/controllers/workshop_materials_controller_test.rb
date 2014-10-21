require 'test_helper'

class WorkshopMaterialsControllerTest < ActionController::TestCase
  setup do
    @workshop_material = workshop_materials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workshop_materials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workshop_material" do
    assert_difference('WorkshopMaterial.count') do
      post :create, workshop_material: { description: @workshop_material.description, file: @workshop_material.file, workshop_id: @workshop_material.workshop_id }
    end

    assert_redirected_to workshop_material_path(assigns(:workshop_material))
  end

  test "should show workshop_material" do
    get :show, id: @workshop_material
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workshop_material
    assert_response :success
  end

  test "should update workshop_material" do
    patch :update, id: @workshop_material, workshop_material: { description: @workshop_material.description, file: @workshop_material.file, workshop_id: @workshop_material.workshop_id }
    assert_redirected_to workshop_material_path(assigns(:workshop_material))
  end

  test "should destroy workshop_material" do
    assert_difference('WorkshopMaterial.count', -1) do
      delete :destroy, id: @workshop_material
    end

    assert_redirected_to workshop_materials_path
  end
end
