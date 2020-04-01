class AddColumnStyleToCocktail < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :style, :string
  end
end
