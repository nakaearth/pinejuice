class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string   "name",               limit: 80, null: false
      t.string   "email",              limit: 255, null: false
      t.string   "provider",           limit: 30,  null: false
      t.string   "nickname",           limit: 80 
      t.string   "uid",                limit: 255, null: false
      t.string   "image_url",          limit: 255
      t.string   "access_token",       limit: 255, null: false
      t.string   "secret_token",       limit: 255, null: false
      t.timestamps
    end
  end
end
