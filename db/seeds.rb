# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
drinks = JSON.load(open(url))
ingredients = drinks['drinks']
mint = { "strIngredient1" => "Mint" }
ingredients << mint
ing = []
ingredients.each do |ingredient|
  ing << ingredient.to_a.reduce
end
ing.sort!
ing.each do |i|
  Ingredient.create(name: i[1])
end







    # Ingredient.create(name: igs['strIngredient1'])













# ingredients.each do |ingredient|
#   Ingredient.create(name: ingredient['strIngredient1'])
# end


