require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
    #would like to wirte in the url a profile name:  localhost:3000/juan
    test "should get show" do
        #need to find it by the profile name using id as params
        get :show, id: users(:juan).profile_name
        assert_response :success
        assert_template 'profiles/show'
    end

    test "should render a 404 on profile not found" do
        get :show, id: "doesn't exist"
        assert_response :not_found
    end

    test "that a variable are assign on successfull profile viewing" do
        get :show, id: users( :juan ).profile_name
        #assigns method Contains instance variables from controllers in a controller test, it make sure instance vatiable and controller are perfectly set.
        assert assigns(:user)
        #making sure there is more than one status,making sure an array contains atleas 1 or more items
        assert_not_empty assigns(:statuses)
    end
    #to make this test to fail, first, I need to add another user to Fixtures
    #pass it, when I changed the profile controller and scope the statuses
    test "only shows the correct user's statuses" do
        get :show, id: users( :juan ).profile_name
        assigns( :statuses ).each do | status |
            assert_equal users( :juan ), status.user
        end
    end

end
