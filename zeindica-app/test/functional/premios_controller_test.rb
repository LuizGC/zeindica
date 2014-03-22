require 'test_helper'

class PremiosControllerTest < ActionController::TestCase
  setup do
    @premio = premios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:premios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show premio" do
    get :show, id: @premio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @premio
    assert_response :success
  end

  test "should destroy premio" do
    assert_difference('Premio.count', -1) do
      delete :destroy, id: @premio
    end

    assert_redirected_to premios_path
  end
end
