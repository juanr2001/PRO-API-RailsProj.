require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest

    test "that /login route opens the login page" do
        get '/login'
        assert_response :success
    end

    test "that /logout route opens the log out page" do
        get '/logout'
        #this will return a 302 (rederect ), so to make it pass with have to use :redirect instead of :success
        # assert_response :success
        assert_response :redirect
        assert_redirected_to '/'
    end

    test "that /register route opens the sign_up page" do
        get '/register'
        assert_response :success
    end


    test "that a profile page works" do
        get "/Juanchito"
        assert_response :success
    end
end
