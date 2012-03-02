require 'test_helper'

class CircleMembersControllerTest < ActionController::TestCase
  setup do
    @circle_member = circle_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:circle_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create circle_member" do
    assert_difference('CircleMember.count') do
      post :create, :circle_member => @circle_member.attributes
    end

    assert_redirected_to circle_member_path(assigns(:circle_member))
  end

  test "should show circle_member" do
    get :show, :id => @circle_member.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @circle_member.to_param
    assert_response :success
  end

  test "should update circle_member" do
    put :update, :id => @circle_member.to_param, :circle_member => @circle_member.attributes
    assert_redirected_to circle_member_path(assigns(:circle_member))
  end

  test "should destroy circle_member" do
    assert_difference('CircleMember.count', -1) do
      delete :destroy, :id => @circle_member.to_param
    end

    assert_redirected_to circle_members_path
  end
end
