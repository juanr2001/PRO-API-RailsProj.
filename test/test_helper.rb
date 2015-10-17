ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

#I guess factory girl requires this step when testing with Unit::Testing, other wise it will throw this error: ArgumentError: Factory not registered: user
 require File.dirname(__FILE__) + "/factories"
class ActiveSupport::TestCase

    include FactoryGirl::Syntax::Methods
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers

end