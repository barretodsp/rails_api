require 'test_helper'

class ProductControllerTest < ActionDispatch::IntegrationTest
  test "should get show," do
    get product_show,_url
    assert_response :success
  end

  test "should get create," do
    get product_create,_url
    assert_response :success
  end

  test "should get delete," do
    get product_delete,_url
    assert_response :success
  end

  test "should get update" do
    get product_update_url
    assert_response :success
  end

end
