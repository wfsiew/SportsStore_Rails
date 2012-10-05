class Product < ActiveRecord::Base
  attr_accessible :category, :description, :imagedata, :imagemimetype, :name, :price, :productID
  
  self.table_name = "product"
end
