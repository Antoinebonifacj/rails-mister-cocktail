class RemoveKnameinIngredient < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :kname, :string
  end
end
