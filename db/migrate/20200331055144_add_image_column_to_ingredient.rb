# frozen_string_literal: true

class AddImageColumnToIngredient < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :photo_url, :string
  end
end
