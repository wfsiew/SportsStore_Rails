require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  test "should create product" do
    product = Product.new
    
    product.name = 'test1'
    product.description = 'test1 description'
    product.price = 678.99
    product.category = 'test'
    
    assert product.save
  end
  
  test "should find product" do
    productID = product(:one).productID
    assert_nothing_raised { Product.find(productID) }
  end
  
  test "should update product" do
    product = product(:two)
    assert product.update_attributes(:description => 'testing')
    
    product.price = 99.1
    assert product.save
    product = Product.find(product.productID)
    assert_equal 99.1, product.price
  end
  
  test "should destroy product" do
    product = product(:one)
    product.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Product.find(product.productID) }
  end
  
  test "should not create a product without required fields" do
    product = Product.new
    assert !product.valid?
    assert product.errors[:name].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:category].any?
    
    assert_equal ['product.blank.name'], product.errors[:name]
    assert_equal ['product.blank.description'], product.errors[:description]
    assert_equal ['product.blank.price', 'product.invalid.price'], product.errors[:price]
    assert_equal ['product.blank.category'], product.errors[:category]
  end
  
end
