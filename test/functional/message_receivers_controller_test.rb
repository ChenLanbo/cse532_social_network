require 'test_helper'

class MessageReceiversControllerTest < ActionController::TestCase
  setup do
    @message_receiver = message_receivers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:message_receivers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message_receiver" do
    assert_difference('MessageReceiver.count') do
      post :create, :message_receiver => @message_receiver.attributes
    end

    assert_redirected_to message_receiver_path(assigns(:message_receiver))
  end

  test "should show message_receiver" do
    get :show, :id => @message_receiver.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @message_receiver.to_param
    assert_response :success
  end

  test "should update message_receiver" do
    put :update, :id => @message_receiver.to_param, :message_receiver => @message_receiver.attributes
    assert_redirected_to message_receiver_path(assigns(:message_receiver))
  end

  test "should destroy message_receiver" do
    assert_difference('MessageReceiver.count', -1) do
      delete :destroy, :id => @message_receiver.to_param
    end

    assert_redirected_to message_receivers_path
  end
end
