require 'test_helper'

class GroupModeratorsControllerTest < ActionController::TestCase
  setup do
    @group_moderator = group_moderators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_moderators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_moderator" do
    assert_difference('GroupModerator.count') do
      post :create, :group_moderator => @group_moderator.attributes
    end

    assert_redirected_to group_moderator_path(assigns(:group_moderator))
  end

  test "should show group_moderator" do
    get :show, :id => @group_moderator.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @group_moderator.to_param
    assert_response :success
  end

  test "should update group_moderator" do
    put :update, :id => @group_moderator.to_param, :group_moderator => @group_moderator.attributes
    assert_redirected_to group_moderator_path(assigns(:group_moderator))
  end

  test "should destroy group_moderator" do
    assert_difference('GroupModerator.count', -1) do
      delete :destroy, :id => @group_moderator.to_param
    end

    assert_redirected_to group_moderators_path
  end
end
