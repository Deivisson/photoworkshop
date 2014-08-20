require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  setup do
    @photo = photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photo" do
    assert_difference('Photo.count') do
      post :create, photo: { aperture: @photo.aperture, camera: @photo.camera, category_id: @photo.category_id, description: @photo.description, focal_lenght: @photo.focal_lenght, iso: @photo.iso, lens: @photo.lens, shutter_speed: @photo.shutter_speed, tags: @photo.tags, taken_at: @photo.taken_at, title: @photo.title, user_id: @photo.user_id }
    end

    assert_redirected_to photo_path(assigns(:photo))
  end

  test "should show photo" do
    get :show, id: @photo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @photo
    assert_response :success
  end

  test "should update photo" do
    patch :update, id: @photo, photo: { aperture: @photo.aperture, camera: @photo.camera, category_id: @photo.category_id, description: @photo.description, focal_lenght: @photo.focal_lenght, iso: @photo.iso, lens: @photo.lens, shutter_speed: @photo.shutter_speed, tags: @photo.tags, taken_at: @photo.taken_at, title: @photo.title, user_id: @photo.user_id }
    assert_redirected_to photo_path(assigns(:photo))
  end

  test "should destroy photo" do
    assert_difference('Photo.count', -1) do
      delete :destroy, id: @photo
    end

    assert_redirected_to photos_path
  end
end
