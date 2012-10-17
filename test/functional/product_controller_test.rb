require 'test_helper'

class ProductControllerTest < ActionController::TestCase
  setup do
    @product = product(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_template 'productspage'
    assert_not_nil assigns(:cart)
    assert_not_nil assigns(:categories)
    assert_not_nil assigns(:products)
    assert_not_nil assigns(:pager)
    assert_not_nil assigns(:category)
  end

  test "should get index_paged" do
    get :index_paged, { 'page' => 1 }
    assert_response :success
    assert_template 'productspage'
    assert_not_nil assigns(:cart)
    assert_not_nil assigns(:categories)
    assert_not_nil assigns(:products)
    assert_not_nil assigns(:pager)
    assert_not_nil assigns(:category)
  end

  test "should get category" do
    get :category, { 'category' => @product.category }
    assert_response :success
    assert_template 'productspage'
    assert_not_nil assigns(:cart)
    assert_not_nil assigns(:categories)
    assert_not_nil assigns(:products)
    assert_not_nil assigns(:pager)
    assert_not_nil assigns(:category)
  end
  
  test "should get category_paged" do
    get :category_paged, { 'category' => @product.category, 'page' => 1 }
    assert_response :success
    assert_template 'productspage'
    assert_not_nil assigns(:cart)
    assert_not_nil assigns(:categories)
    assert_not_nil assigns(:products)
    assert_not_nil assigns(:pager)
    assert_not_nil assigns(:category)
  end
  
end
