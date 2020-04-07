# frozen_string_literal: true

class CreateAlcoholics < ActiveRecord::Migration[5.2]
  def change
    create_table :alcoholics do |t|
      t.string :name

      t.timestamps
    end
  end
end
