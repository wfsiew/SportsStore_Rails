class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.primary_key :productID
      t.string :name
      t.string :description
      t.float :price
      t.string :category
      t.binary :imagedata
      t.string :imagemimetype
    end
  end
end
