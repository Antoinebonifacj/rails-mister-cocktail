class AddIngredientsAndMeasuresToCocktail < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :ingredient1, :string
    add_column :cocktails, :ingredient2, :string
    add_column :cocktails, :ingredient3, :string
    add_column :cocktails, :ingredient4, :string
    add_column :cocktails, :ingredient5, :string
    add_column :cocktails, :ingredient6, :string
    add_column :cocktails, :measure1, :string
    add_column :cocktails, :measure2, :string
    add_column :cocktails, :measure3, :string
    add_column :cocktails, :measure4, :string
    add_column :cocktails, :measure5, :string
    add_column :cocktails, :measure6, :string
  end
end
