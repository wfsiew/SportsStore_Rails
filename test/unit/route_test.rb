require 'test_helper'

class RouteTest < ActionController::TestCase
  
  test "should route to product" do
    assert_routing '/product', { :controller => 'product', :action => 'index' }
    assert_routing '/product/index/2', { :controller => 'product', :action => 'index_paged', :page => '2' }
    assert_routing '/product/soccer', { :controller => 'product', :action => 'category', :category => 'soccer' }
    assert_routing '/product/chess/3', { :controller => 'product', :action => 'category_paged', :category => 'chess', :page => '3' }
  end
  
  test "should route to cart" do
    assert_routing '/cart', { :controller => 'cart', :action => 'index' }
    assert_routing({ :method => :post, :path => '/cart/add/2' }, { :controller => 'cart', :action => 'add', :id => '2' })
    assert_routing({ :method => :post, :path => '/cart/remove/2' }, { :controller => 'cart', :action => 'remove', :id => '2' })
    assert_routing '/cart/checkout', { :controller => 'cart', :action => 'checkout' }
  end
  
  test "should route to admin" do
    assert_routing '/admin/product', { :controller => 'admin/product', :action => 'index' }
    assert_routing '/admin/product/new', { :controller => 'admin/product', :action => 'new' }
    assert_routing({ :method => :post, :path => '/admin/product/create' }, { :controller => 'admin/product', :action => 'create' })
    assert_routing '/admin/product/edit/3', { :controller => 'admin/product', :action => 'edit', :id => '3' }
    assert_routing({ :method => :put, :path => '/admin/product/update/3' }, { :controller => 'admin/product', :action => 'update', :id => '3' })
    assert_routing '/admin/product/delete/3', { :controller => 'admin/product', :action => 'destroy', :id => '3' }
    
    assert_routing '/admin/login', { :controller => 'admin/admin', :action => 'new' }
    assert_routing '/admin/auth', { :controller => 'admin/admin', :action => 'create' }
    assert_routing '/admin/logout', { :controller => 'admin/admin', :action => 'destroy' }
  end
  
  test "should route to mobile" do
    assert_routing '/mobile/product', { :controller => 'mobile/product', :action => 'index' }
    assert_routing '/mobile/product/index/5', { :controller => 'mobile/product', :action => 'index_paged', :page => '5' }
    assert_routing '/mobile/product/soccer', { :controller => 'mobile/product', :action => 'category', :category => 'soccer' }
    assert_routing '/mobile/product/chess/3', { :controller => 'mobile/product', :action => 'category_paged', :category => 'chess', :page => '3' }
    assert_routing({ :method => :post, :path => '/mobile/product/list/8' }, { :controller => 'mobile/product', :action => 'list_paged', :page => '8' })
    
    assert_routing '/mobile/cart', { :controller => 'mobile/cart', :action => 'index' }
    assert_routing '/mobile/cart/add/2', { :controller => 'mobile/cart', :action => 'add', :id => '2' }
    assert_routing '/mobile/cart/remove/2', { :controller => 'mobile/cart', :action => 'remove', :id => '2' }
    assert_routing '/mobile/cart/checkout', { :controller => 'mobile/cart', :action => 'checkout' }
  end
end
