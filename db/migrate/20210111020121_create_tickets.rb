# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :title, limit: 80, null: false
      t.string :description, limit: 1024, null: false
      t.integer :point, default: 0
      t.references :user, index: true
      t.timestamps
    end
  end
end
