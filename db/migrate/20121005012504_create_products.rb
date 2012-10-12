class CreateProducts < ActiveRecord::Migration
  def change
    create_table :product, :id => false, :force => false do |t|
      t.primary_key :productID
      t.string :name, :null => false
      t.string :description, :null => false
      t.float :price, :null => false
      t.string :category, :null => false
      t.binary :imagedata
      t.string :imagemimetype
    end
  end
end
