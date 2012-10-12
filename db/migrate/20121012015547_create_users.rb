class CreateUsers < ActiveRecord::Migration
  def change
    create_table :user, :force => true do |t|
      t.string :username, :limit => 50, :null => false
      t.string :password, :null => false
    end
  end
end
