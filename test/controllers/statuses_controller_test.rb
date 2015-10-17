require 'test_helper'

class StatusesControllerTest < ActionController::TestCase

  setup do
    @status = statuses(:one)
    # @user = sign_in users(:juan)
  end

#INDEX
  test "should get index" do
    sign_in users(:juan)
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses, :gravatar_url)
    logger.info
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

  test "should create status for the current user when logged in" do
      sign_in users(:juan)
      assert_difference('Status.count') do
      #need to pass the other user
      post :create, status: { content: @status.content, user_id: users( :jose ).id }
    end

    assert_redirected_to status_path(assigns(:status))
    #status user id is the same as juan id from fixture
    assert_equal assigns( :status ).user_id, users( :juan).id
  end

#SHOW
  test "should show status when logged in" do
    get :show, id: @status
    assert_response :success
  end

#EDIT

test "should redirect edit when not logged in" do
    get :edit, id: @status
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should get edit when logged in" do
    sign_in users(:juan)
    get :edit, id: @status
    assert_response :success
  end

#UPDATE
  test "should update status when logged in" do
    sign_in users(:juan)
    put :update, id: @status, status: { content: @status.content }
    assert_redirected_to status_path(assigns(:status))
  end

  test "should update status for current user when logged in" do
    sign_in users(:juan)
    patch :update, id: @status, status: { content: @status.content, user_id: users(:jose).id }
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:juan).id
  end

 # test "should not update status if nothing has changed" do
 #    sign_in users(:juan)
 #    patch :update, id: @status
 #    assert_redirected_to status_path(assigns(:status))
 #    assert_equal assigns(:status).user_id, users(:juan).id
 #  end

#DESTROY
  test "should destroy status when logged in" do
    sign_in users(:juan)
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end
