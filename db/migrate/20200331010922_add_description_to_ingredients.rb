class AddDescriptionToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :description, :text
  end
end
