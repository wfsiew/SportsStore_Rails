class Product < ActiveRecord::Base
  include ActionView::Helpers::TagHelper
  
  attr_accessible :category, :description, :imagedata, :imagemimetype, :name, :price, :productID
  
  self.table_name = 'product'
  
  default_scope select([:category, :description, :imagemimetype, :name, :price, :productID])
  
  validates_presence_of :name, :message => 'product.blank.name'
  validates_presence_of :description, :message => 'product.blank.description'
  validates_presence_of :price, :message => 'product.blank.price'
  validates_numericality_of :price, :greater_than_or_equal_to => 0, :message => 'product.invalid.price'
  validates_presence_of :category, :message => 'product.blank.category'
  
  def show_error(key)
    if errors.has_key?(key)
      content_tag(:span, I18n.t(errors[key].first), :class => 'form_error')
    end
  end
end
