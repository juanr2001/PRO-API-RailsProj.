require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works without raising an exception" do
    assert_nothing_raised do
        UserFriendship.create user: users( :juan ), friend: users( :caramelo )
    end
  end

  test "that creating a friendship based on user id and friend id works" do
    UserFriendship.create user_id: users( :juan ).id, friend_id: users( :caramelo).id
    #I don't need reload because I have get to the associations
    assert users( :juan ).friends.include?( users( :caramelo ) )
  end
end
