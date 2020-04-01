require 'json'
require 'open-uri'

 #Storing api's urls
url1 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'
url2 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list'
# url3 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
url4 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?a=list'

# Parsing apis urls
categories = JSON.parse(open(url1).read)
glasses = JSON.parse(open(url2).read)
alcoholics = JSON.parse(open(url4).read)

# Saving data in json files
File.open('db/categories.json', 'wb') do |file|
  file.write(categories)
  puts 'saving data...'
end

File.open('db/glasses.json', 'wb') do |file|
  file.write(glasses)
  puts 'saving data...'
end

File.open('db/alcoholics.json', 'wb') do |file|
  file.write(alcoholics)
  puts 'saving data...'
end


puts "Creating Categories..."
cat = []
categories["drinks"].each do |category|
  cat << category
end

# Creating category object
cat.each do |i|
  Category.create(name: i['strCategory'])
end


puts "Creating Glasses..."
gla = []
glasses['drinks'].each do |glass|
  gla << glass
end
  # Creating glass object
gla.each do |i|
  Glass.create(name: i['strGlass'])
end


puts 'Creating Alcoholics...'
alc = []
alcoholics['drinks'].each do |alcoholic|
  alc << alcoholic
end

  # Creating alcoholic object

alc.each do |i|
  Alcoholic.create(name: i['strAlcoholic'])
end

puts "Creating Ingredients..."
ingredients = {}
i = 1
until i == 600
  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=#{i}"
  ingredients = JSON.parse(open(url).read)
  unless ingredients['ingredients'].nil?
    Ingredient.create(
    name: ingredients['ingredients'][0]['strIngredient'],
    description: ingredients['ingredients'][0]['strDescription'],
    sort: ingredients['ingredients'][0]['strType'],
    alcohol: ingredients['ingredients'][0]['strAlcohol'],
    perc: ingredients['ingredients'][0]['strABV'],
    photo_url: "https://www.thecocktaildb.com/images/ingredients/#{ingredients['ingredients'][0]['strIngredient']}.png"
  )
  puts "create #{ingredients['ingredients'][0]['strIngredient']}"
  end
  i += 1
end

File.open('db/ingredients.json', 'wb') do |file|
  file.write(ingredients)
end


puts 'Creating Cocktails...'

cocktails = {}
i = 11_000
until i == 13_000
  url1 = "https://thecocktaildb.com/api/json/v1/1/lookup.php?i=#{i}"
  cocktails = JSON.parse(open(url1).read)
  unless cocktails['drinks'].nil?
    coc = Cocktail.new(
      name: cocktails['drinks'][0]['strDrink'],
      description: cocktails['drinks'][0]['strInstructions'],
      style: cocktails['drinks'][0]['strCategory'],
      photo_url: cocktails['drinks'][0]['strDrinkThumb']
    )
    coc.save(validate: false)
    puts "create #{cocktails['drinks'][0]['strDrink']}"
  end
  i += 1
end

File.open('db/cocktails.json', 'wb') do |file|
  file.write(cocktails)
end

puts "Finish!!"
