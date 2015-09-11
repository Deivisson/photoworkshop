require 'test_helper'

class WorkshopActivityResponsesControllerTest < ActionController::TestCase
  setup do
    @workshop_activity_response = workshop_activity_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workshop_activity_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workshop_activity_response" do
    assert_difference('WorkshopActivityResponse.count') do
      post :create, workshop_activity_response: { user_id: @workshop_activity_response.user_id, workshop_id: @workshop_activity_response.workshop_id }
    end

    assert_redirected_to workshop_activity_response_path(assigns(:workshop_activity_response))
  end

  test "should show workshop_activity_response" do
    get :show, id: @workshop_activity_response
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workshop_activity_response
    assert_response :success
  end

  test "should update workshop_activity_response" do
    patch :update, id: @workshop_activity_response, workshop_activity_response: { user_id: @workshop_activity_response.user_id, workshop_id: @workshop_activity_response.workshop_id }
    assert_redirected_to workshop_activity_response_path(assigns(:workshop_activity_response))
  end

  test "should destroy workshop_activity_response" do
    assert_difference('WorkshopActivityResponse.count', -1) do
      delete :destroy, id: @workshop_activity_response
    end

    assert_redirected_to workshop_activity_responses_path
  end
end
