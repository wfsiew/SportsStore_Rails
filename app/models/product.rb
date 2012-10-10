class Product < ActiveRecord::Base
  include ActionView::Helpers::TagHelper
  
  attr_accessible :category, :description, :imagedata, :imagemimetype, :name, :price, :productID
  
  self.table_name = 'product'
  
  default_scope select([:category, :description, :imagemimetype, :name, :price, :productID])
  
  validates_presence_of :name, :message => I18n.t('product.blank.name')
  validates_presence_of :description, :message => I18n.t('product.blank.description')
  validates_presence_of :price, :message => I18n.t('product.blank.price')
  validates_numericality_of :price, :greater_than_or_equal_to => 0, :message => I18n.t('product.invalid.price')
  validates_presence_of :category, :message => I18n.t('product.blank.category')
  
  def show_error(key)
    if errors.has_key?(key)
      content_tag(:span, errors.get(key).first, :class => 'form_error')
    end
  end
end
