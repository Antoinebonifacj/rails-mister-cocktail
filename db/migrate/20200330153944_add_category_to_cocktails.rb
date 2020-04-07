# frozen_string_literal: true

class AddCategoryToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_reference :cocktails, :category, foreign_key: true
  end
end
