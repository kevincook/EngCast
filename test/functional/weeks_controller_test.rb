require 'test_helper'

class WeeksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weeks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create week" do
    assert_difference('Week.count') do
      post :create, :week => { }
    end

    assert_redirected_to week_path(assigns(:week))
  end

  test "should show week" do
    get :show, :id => weeks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => weeks(:one).to_param
    assert_response :success
  end

  test "should update week" do
    put :update, :id => weeks(:one).to_param, :week => { }
    assert_redirected_to week_path(assigns(:week))
  end

  test "should destroy week" do
    assert_difference('Week.count', -1) do
      delete :destroy, :id => weeks(:one).to_param
    end

    assert_redirected_to weeks_path
  end
end
