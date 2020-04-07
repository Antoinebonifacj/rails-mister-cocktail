# frozen_string_literal: true

class AddAlcoholicToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_reference :cocktails, :alcoholic, foreign_key: true
  end
end
