require 'test_helper'

class WorkshopPlansControllerTest < ActionController::TestCase
  setup do
    @workshop_plan = workshop_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workshop_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workshop_plan" do
    assert_difference('WorkshopPlan.count') do
      post :create, workshop_plan: { active: @workshop_plan.active, description: @workshop_plan.description, settings: @workshop_plan.settings }
    end

    assert_redirected_to workshop_plan_path(assigns(:workshop_plan))
  end

  test "should show workshop_plan" do
    get :show, id: @workshop_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workshop_plan
    assert_response :success
  end

  test "should update workshop_plan" do
    patch :update, id: @workshop_plan, workshop_plan: { active: @workshop_plan.active, description: @workshop_plan.description, settings: @workshop_plan.settings }
    assert_redirected_to workshop_plan_path(assigns(:workshop_plan))
  end

  test "should destroy workshop_plan" do
    assert_difference('WorkshopPlan.count', -1) do
      delete :destroy, id: @workshop_plan
    end

    assert_redirected_to workshop_plans_path
  end
end
