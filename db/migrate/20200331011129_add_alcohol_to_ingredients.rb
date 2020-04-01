class AddAlcoholToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :alcohol, :string
  end
end
