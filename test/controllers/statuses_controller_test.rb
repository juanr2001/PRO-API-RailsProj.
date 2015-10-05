require 'test_helper'

class StatusesControllerTest < ActionController::TestCase

  setup do
    @status = statuses(:one)
    # @user = sign_in users(:juan)
  end

#INDEX
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

#LOGGED IN-OUT
  test "should be redirected when not logged in" do
    get :new
    #not what we want if they are not login, so instead I used redirect
    # assert_response :success
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the new page when logged in" do
    #users(:juan) got it from fixtures
    sign_in users(:juan)
    get :new
    assert_response :success

  end

#CREATE
  test "should be logged in to post a status" do
    post :create, status: { content: "Hello" }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should create status when logged in" do
      sign_in users(:juan)
      assert_difference('Status.count') do
      post :create, status: { content: @status.content }
    end

    assert_redirected_to status_path(assigns(:status))
  end

#SHOW
  test "should show status when logged in" do
    get :show, id: @status
    assert_response :success
  end

#EDIT
  test "should get edit when logged in" do
    get :edit, id: @status
    assert_response :success
  end

#UPDATE
  test "should update status when logged in" do
    sign_in users(:juan)
    patch :update, id: @status, status: { content: @status.content }
    assert_redirected_to status_path(assigns(:status))
  end

#DESTROY
  test "should destroy status when logged in" do
    sign_in users(:juan)
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end
