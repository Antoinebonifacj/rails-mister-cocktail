class AddGlassToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_reference :cocktails, :glass, foreign_key: true
  end
end
