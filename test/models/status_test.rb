require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "that a status requires content" do
    status = Status.new
    #make sure is not save
    status.content = ""
    assert !status.save, "Content must be more than 2 characters"
    #and give me an error message
    assert !status.errors[:content].empty?
  end

  test "that a status's content is at least 2 letters" do
    status = Status.new
    status.content = "h"
    assert !status.save, "Content must be more than 2 characters"
    assert !status.errors[:content].empty?
  end

  test "that a status has a user id" do
    status = Status.new
    status.content = "Hello"

    assert !status.save
    assert !status.errors[:user_id].empty?
  end

end
