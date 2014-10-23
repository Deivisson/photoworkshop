require 'test_helper'

class WorkshopActivitiesControllerTest < ActionController::TestCase
  setup do
    @workshop_activity = workshop_activities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workshop_activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workshop_activity" do
    assert_difference('WorkshopActivity.count') do
      post :create, workshop_activity: { description: @workshop_activity.description, details: @workshop_activity.details, limit_date: @workshop_activity.limit_date, status: @workshop_activity.status }
    end

    assert_redirected_to workshop_activity_path(assigns(:workshop_activity))
  end

  test "should show workshop_activity" do
    get :show, id: @workshop_activity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workshop_activity
    assert_response :success
  end

  test "should update workshop_activity" do
    patch :update, id: @workshop_activity, workshop_activity: { description: @workshop_activity.description, details: @workshop_activity.details, limit_date: @workshop_activity.limit_date, status: @workshop_activity.status }
    assert_redirected_to workshop_activity_path(assigns(:workshop_activity))
  end

  test "should destroy workshop_activity" do
    assert_difference('WorkshopActivity.count', -1) do
      delete :destroy, id: @workshop_activity
    end

    assert_redirected_to workshop_activities_path
  end
end
