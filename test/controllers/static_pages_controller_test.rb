<<<<<<< HEAD
# require 'test_helper'
=======
require 'test_helper'
>>>>>>> statis-pages

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", " Ruby on Rails Tutorial Sample App"
  end
test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Home | Ruby on Rails Tutorial Sample App"
  end
test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "Home | Ruby on Rails Tutorial Sample App"
  end
def string_message(str = '')
   if str.empty?
    "It's an empty string!"
  else
     "The string is nonempty."
   end
end
end
#require 'test_helper'

#class StaticPagesControllerTest < ActionController::TestCase

  #def setup
   # @base_title = "Ruby on Rails Tutorial Sample App"
  #end

  #test "should get home" do
    #get :home
    #assert_response :success
    #assert_select "title", "Home | #{@base_title}"
  #end

  #test "should get help" do
   # get :help
   # assert_response :success
    #assert_select "title", "Help | #{@base_title}"
  #end

  #test "should get about" do
   # get :about
    #assert_response :success
   # assert_select "title", "About | #{@base_title}"
 # end
#end
