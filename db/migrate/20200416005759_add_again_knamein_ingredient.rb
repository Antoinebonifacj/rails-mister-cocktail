class AddAgainKnameinIngredient < ActiveRecord::Migration[5.2]
  def self.up
    #Code to migrate 
    add_column :ingredients, :kname, :string
    Ingredient.all.each do |ing|
      ing.update(kname: ing.name.parameterize.underscore)
    end
  end

  def self.down
    remove_column :ingredients, :kname
  end
end
