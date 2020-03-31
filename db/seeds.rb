require 'json'
require 'open-uri'

# Storing api's urls

url1 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'
url2 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list'
url3 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
url4 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?a=list'

# Parsing apis urls
categories = JSON.parse(open(url1).read)
glasses = JSON.parse(open(url2).read)
ingredients = JSON.parse(open(url3).read)
alcoholics = JSON.parse(open(url4).read)

puts "Creating Ingredients..."
  # Reducing
ing = []
ingredients["drinks"].each do |ingredient|
  ing << ingredient
end
ing
  # Sorting alphabetically
  # Creating Ingredient object
ing.each do |i|
  Ingredient.create(name: i["strIngredient1"])
end


puts "Creating Categories..."
cat = []
categories["drinks"].each do |category|
  cat << category
end
  # Sorting alphabetically
  # Creating category object
cat.each do |i|
  Category.create(name: i["strCategory"])
end


puts "Creating Glasses..."
gla = []
glasses["drinks"].each do |glass|
  gla << glass
end
  # Sorting alphabetically
  # Creating glass object
gla.each do |i|
  Glass.create(name: i["strGlass"])
end


puts "Creating Alcoholics..."
alc = []
alcoholics["drinks"].each do |alcoholic|
  alc << alcoholic
end
  # Creating alcoholic object
alc.each do |i|
  Alcoholic.create(name: i["strAlcoholic"])
end

puts "Finish!!"
