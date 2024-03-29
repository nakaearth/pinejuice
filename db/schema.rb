# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_111_020_121) do
  create_table 'tickets', charset: 'utf8mb4', collation: 'utf8mb4_general_ci', force: :cascade do |t|
    t.string 'title', limit: 80, null: false
    t.string 'description', limit: 1024, null: false
    t.integer 'point', default: 0
    t.bigint 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_tickets_on_user_id'
  end

  create_table 'users', charset: 'utf8mb4', collation: 'utf8mb4_general_ci', force: :cascade do |t|
    t.string 'name', limit: 80, null: false
    t.string 'email', null: false
    t.string 'provider', limit: 30, null: false
    t.string 'nickname', limit: 80
    t.string 'uid', null: false
    t.string 'image_url'
    t.string 'access_token', null: false
    t.string 'secret_token', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end
end
