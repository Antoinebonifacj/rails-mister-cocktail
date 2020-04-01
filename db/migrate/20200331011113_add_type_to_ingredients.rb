class AddTypeToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :type, :string
  end
end
