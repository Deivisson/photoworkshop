require 'test_helper'

class PhotoCommentsControllerTest < ActionController::TestCase
  setup do
    @photo_comment = photo_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photo_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photo_comment" do
    assert_difference('PhotoComment.count') do
      post :create, photo_comment: { content: @photo_comment.content, photo_id: @photo_comment.photo_id, user_id: @photo_comment.user_id }
    end

    assert_redirected_to photo_comment_path(assigns(:photo_comment))
  end

  test "should show photo_comment" do
    get :show, id: @photo_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @photo_comment
    assert_response :success
  end

  test "should update photo_comment" do
    patch :update, id: @photo_comment, photo_comment: { content: @photo_comment.content, photo_id: @photo_comment.photo_id, user_id: @photo_comment.user_id }
    assert_redirected_to photo_comment_path(assigns(:photo_comment))
  end

  test "should destroy photo_comment" do
    assert_difference('PhotoComment.count', -1) do
      delete :destroy, id: @photo_comment
    end

    assert_redirected_to photo_comments_path
  end
end
