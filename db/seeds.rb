# frozen_string_literal: true

require 'pry'
require 'json'
require 'open-uri'

# Storing api's urls
#url1 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'
#url2 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list'
### url3 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
#url4 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?a=list'
##
### Parsing apis urls
# categories = JSON.parse(open(url1).read)
# glasses = JSON.parse(open(url2).read)
# alcoholics = JSON.parse(open(url4).read)
# #categories = JSON.parse(File.read(filepath1))
# #glasses = JSON.parse(File.read(filepath2))
# #alcoholics = JSON.parse(File.read(filepath3))
##
### Saving data in json files
###
###
##
filepath1 = 'db/categories.json'
filepath2 = 'db/glasses.json'
filepath3 = 'db/alcoholics.json'
filepath4 = 'db/ingredients.json'
filepath5 = 'db/cocktails.json'
filepath6 = 'db/doses.json'
##
##
## Creating Category object
puts 'Creating Categories...'
cat = JSON.parse(File.read(filepath1))
cat.each do |i|
  unless i.nil?
    Category.create(
      name: i['name'],
      kname: i['name'].parameterize.underscore
    )
  end
end
#File.open('db/categories.json', 'wb') do |file|
#  file.write(cat.to_json)
#  puts 'saving categories...'
#end
#
## Creating Glass object
puts 'Creating Glasses...'
gla = JSON.parse(File.read(filepath2))
gla.each do |i|
  unless i.nil?
    Glass.create(name: i['name'])
  end
end
#File.open('db/glasses.json', 'wb') do |file|
#  file.write(gla.to_json)
#  puts 'saving glasses...'
#end
#
# Creating Alcoholic object
puts 'Creating Alcoholics...'
alc = JSON.parse(File.read(filepath3))
alc.each do |i|
  unless i.nil?
    Alcoholic.create(name: i['name'])
  end
end
#File.open('db/alcoholics.json', 'wb') do |file|
#  file.write(alc.to_json)
#  puts 'saving alcoholics...'
#end
#
puts 'Scrapping Ingredients...'
#ingrdt = []
#i = 1
#until i == 700
#  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=#{i}"
#  ingredientss = JSON.parse(open(url).read)
#  unless ingredientss['ingredients'].nil?
#    ingredient = {
#      name: ingredientss['ingredients'][0]['strIngredient'].downcase,
#      description: ingredientss['ingredients'][0]['strDescription'],
#      sort: ingredientss['ingredients'][0]['strType'],
#      alcohol: ingredientss['ingredients'][0]['strAlcohol'],
#      perc: ingredientss['ingredients'][0]['strABV'],
#      photo_url: "https://www.thecocktaildb.com/images/ingredients/#{ingredientss['ingredients'][0]['strIngredient']}.png",
#      kname: ingredientss['ingredients'][0]['strIngredient'].parameterize.underscore
#    }
#    ingrdt << ingredient
#    puts "scrapping #{ingredientss['ingredients'][0]['strIngredient']}"
#  end
#  i += 1
#end
#
#File.open('db/ingredients.json', 'w') do |file|
#  file.write(ingrdt.to_json)
#  puts "saving ingredients"
#end
puts "Creating Ingredients..."
ingredients = JSON.parse(File.read(filepath4))
ingredients.each do |i|
  unless i['name'].nil?
    Ingredient.create(
      name: i['name'],
      description: i['description'],
      sort: i['sort'],
      alcohol: i['alcohol'],
      perc: i['perc'],
      photo_url: i['photo_url'],
      kname: i['kname']
    )
    puts "create #{i['name']}"
  end
end

puts 'Scrapping Cocktails...'

cktls = []
k = 11_000
until k == 16_000
  url5 = "https://thecocktaildb.com/api/json/v1/1/lookup.php?i=#{k}"
  cocktailss = JSON.parse(open(url5).read)
  cockt = cocktailss['drinks']
  if !cockt.nil? && !cockt[0].nil?
    coc = {
      name: cockt[0]['strDrink'].downcase,
      description: cockt[0]['strInstructions'],
      style: cockt[0]['strCategory'].downcase,
      category_id: Category.find_by(kname: cockt[0]['strCategory'].parameterize.underscore).id,
      glass_id: Glass.find_by(name: cockt[0]['strGlass'].downcase).id,
      alcoholic_id: Alcoholic.find_by(name: cockt[0]['strAlcoholic']).id,
      photo_url: cockt[0]['strDrinkThumb'],
      kname: cockt[0]['strDrink'].parameterize.underscore,
      measure1: cockt[0]["strMeasure1"],
      measure2: cockt[0]["strMeasure2"],
      measure3: cockt[0]["strMeasure3"],
      measure4: cockt[0]["strMeasure4"],
      measure5: cockt[0]["strMeasure5"],
      measure6: cockt[0]["strMeasure6"]
    }
    m = 1
    if m <= 6 && !cockt[0]["strIngredient#{m}"].nil?
      coc["ingredient#{m}"] = Ingredient.find_by(kname: cockt[0]["strIngredient#{m}"].parameterize.underscore).kname
      m += 1
    end
    cktls << coc
    puts "scrap #{cockt[0]['strDrink']}"
  end
  k += 1
end

File.open('db/cocktails.json', 'wb') do |file|
  file.write(cktls.to_json)
  puts 'saving cocktails...'
end

puts 'Scrapping done...'
puts 'Creating Cocktails..'
cocktails = JSON.parse(File.read(filepath5))
cocktails.each do |i|
  unless i['name'].nil? 
    Cocktail.create(
      name: i['name'],
      description: i['description'],
      style: i['style'],
      category_id: i['category_id'],
      glass_id: i['glass_id'],
      alcoholic_id: i['alcoholic_id'],
      photo_url: i['photo_url'],
      kname: i['name'].parameterize.underscore,
      ingredient1: i['ingredient1'],
      ingredient2: i['ingredient2'],
      ingredient3: i['ingredient3'],
      ingredient4: i['ingredient4'],
      ingredient5: i['ingredient5'],
      ingredient6: i['ingredient6'],
      measure1: i['measure1'],
      measure2: i['measure2'],
      measure3: i['measure3'],
      measure4: i['measure4'],
      measure5: i['measure5'],
      measure6: i['measure6']
    )
    puts "create #{i['name']}"
  end
end
puts "Cocktail's creation done"
puts 'Scrapping Doses...'

ds = []
cocktails.each do |i|
  m = 1
  if m <= 6 && !i["ingredient#{m}"].nil?
    dose = {
      measure: i["measure#{m}"],
      cocktail_id: Cocktail.find_by(kname: i['kname']).id,
      ingredient_id: Ingredient.find_by(kname: i["ingredient#{m}"]).id
    }
    m += 1
    ds << dose
  end
end

File.open('db/doses.json', 'wb') do |file|
  file.write(ds.to_json)
  puts "saving doses..."
end

puts 'creating doses...'
doses = JSON.parse(File.read(filepath6))
doses.each do |i|
  unless i['ingredient_id'].nil?
    Dose.create(
      measure: i["measure"],
      cocktail_id: i['cocktail_id'],
      ingredient_id: i["ingredient_id"]
    )
    puts "creating dose of #{Ingredient.find_by(id: i['ingredient_id'].to_i).name}"
  end
end
#cktls.each do |cocktail|
#  j = 1
#  until j == 15
#    unless cocktail.nil? && cockt[0]["strMeasure#{j}"].nil? 
#      puts "create dose of #{cockt[0]["strIngredient#{j}"]}"
#      binding.pry
#      Dose.create(
#        measure: cockt[0]["strMeasure#{j}"],
#        cocktail_id: cocktail.id,
#        ingredient_id: Ingredient.find_by(kname: cockt[0]["strIngredient#{j}"].parameterize.underscore).id
#      )
#    end
#  end
#end
#  puts "create #{cockt[0]['strDrink']}"
#  measure = cockt[0]["strMeasure#{j}"]
#  ing = cockt[0]["strIngredient#{j}"]
#  ingd = Ingredient.where(kname: ing.parameterize.underscore)
#  unless measure.nil?
#    dose = Dose.new(
  #      measure: measure,
#      cocktail_id: coc.id,
#      ingredient_id: ingd[0].id
#    )
#    dose.save(validate: false)
#  end
#  puts "Creating Doses of #{ing}..."
#  j += 1
#end
puts 'Finish!!'
