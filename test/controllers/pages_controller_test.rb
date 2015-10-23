require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get select_repo' do
    get :select_repo
    assert_response :success
  end
end
