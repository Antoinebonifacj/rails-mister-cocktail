# frozen_string_literal: true

class AddPercToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :perc, :integer
  end
end
