require 'test_helper'

class HelloControllerTest < ActionController::TestCase
  def test_get_on_index
    get :index
    assert_response :success
  end

  def test_get_on_index_should_display_hello_world
    get :index
    assert_select "h1", "Hello World"
  end
end
