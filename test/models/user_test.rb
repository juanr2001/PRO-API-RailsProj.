require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

    should have_many( :user_friendships )
    should have_many( :friends )

    test "a user should enter a first name" do
        user = User.new
        assert !user.save
        #passing error object to first name is not empty, this will fail but, but will pass if there is a validation in the models.
        assert !user.errors[ :first_name ].empty?
    end

    test "a user should enter a last name" do
        user = User.new
        assert !user.save
        #passing error object to first name is not empty, this will fail but, but will pass if there is a validation in the models.
        assert !user.errors[ :last_name ].empty?
    end

    test "a user should enter a profile name" do
        user = User.new
        assert !user.save
        #passing error object to first name is not empty, this will fail but, but will pass if there is a validation in the models.
        assert !user.errors[ :profile_name ].empty?
    end

    test "a user should have a unique profile name" do
        user = User.new
        #calling the fixture/users.yml (:juan) in the parenthesis and call its profile_name. I used users, becuase that is the name of the file.
        user.profile_name = users(:juan).profile_name
        #If I put the password in the fixtures the test will fail
        user.password = "password"
        user.password_confirmation = "password"
        assert !user.save
        assert !user.errors[ :profile_name ].empty?
    end

    test "a user should have a profile name without spaces" do
        user = User.new(first_name: "Juan", last_name: "Ordaz", email: 'juanordaz_2011@yahoo.com')
        user.password = user.password_confirmation = "password"

        user.profile_name = "My Profile with Spaces"

        assert !user.save
        #make sure there are some errors in the profile name
        assert !user.errors[ :profile_name ].empty?
        #make sure there is a correct errors message
        assert user.errors[ :profile_name ].include?( "Must be formatted correctly." )
    end

    test "a user can have a correctly formatted profile name" do
        user = User.new(first_name: "Juan", last_name: "Ordaz", email: 'juanordaz_2011@yahoo.com')
        user.password = user.password_confirmation = "password"

        user.profile_name = "Juancho"
        assert user.valid?
    end

    test " that no error is raised when trying to access a friend list" do
        assert_nothing_raised do
            users(:juan).friends
        end
    end

    test "that creating friendships on a user works" do
        users( :juan ).friends << users( :caramelo )
        users( :juan ).friends.reload
        assert users( :juan ).friends.include?( users( :caramelo ) )
    end

    test "that calling to_param on a user returns the profile_name" do
        assert_equal "Juanchito", users(:juan).to_param
    end

end
