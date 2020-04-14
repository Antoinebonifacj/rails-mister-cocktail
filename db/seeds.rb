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
##filepath1 = 'db/categories.json'
##filepath2 = 'db/glasses.json'
##filepath3 = 'db/alcoholics.json'
#filepath4 = 'db/ingredients.json'
##
##
## Creating Category object
#puts 'Creating Categories...'
#cat = []
#categories['drinks'].each do |i|
#  catg = Category.create(name: i['strCategory'].downcase)
#  cat << catg
#end
#File.open('db/categories.json', 'wb') do |file|
#  file.write(cat.to_json)
#  puts 'saving categories...'
#end
#
## Creating Glass object
#puts 'Creating Glasses...'
#gla = []
#glasses['drinks'].each do |i|
#  glss = Glass.create(name: i['strGlass'].downcase)
#  gla << glss
#end
#File.open('db/glasses.json', 'wb') do |file|
#  file.write(gla.to_json)
#  puts 'saving glasses...'
#end
#
## Creating Alcoholic object
#puts 'Creating Alcoholics...'
#alc = []
#alcoholics['drinks'].each do |i|
# alch = Alcoholic.create(name: i['strAlcoholic'])
# alc << alch
#end
#File.open('db/alcoholics.json', 'wb') do |file|
#  file.write(alc.to_json)
#  puts 'saving alcoholics...'
#end
#
#puts 'Creating Ingredients...'
##ingredients = JSON.parse(File.read(filepath4))
##ingredients.each do |i|
##  Ingredient.create(
##    name: i['name'],
##    description: i['description'],
##    sort: i['sort'],
##    alcohol: i['alcohol'],
##    perc: i['perc'],
##    photo_url: i['photo_url']
##  )
##  puts "create #{i['name']}"
##end
#ingrdt = []
#i = 1
#until i == 700
# url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=#{i}"
# ingredients = JSON.parse(open(url).read)
# unless ingredients['ingredients'].nil?
#   ingredient = Ingredient.create(
#     name: ingredients['ingredients'][0]['strIngredient'].downcase!,
#     description: ingredients['ingredients'][0]['strDescription'],
#     sort: ingredients['ingredients'][0]['strType'],
#     alcohol: ingredients['ingredients'][0]['strAlcohol'],
#     perc: ingredients['ingredients'][0]['strABV'],
#     photo_url: "https://www.thecocktaildb.com/images/ingredients/#{ingredients['ingredients'][0]['strIngredient']}.png"
#   )
#   ingrdt << ingredient
#   puts "create #{ingredients['ingredients'][0]['strIngredient']}"
# end
# i += 1
#end
#
#File.open('db/ingredients.json', 'w') do |file|
# file.write(ingrdt.to_json)
# puts "saving ingredients"
#end

puts 'Creating Cocktails...'
cktls = []
j = 1
k = 11_000
until k == 11_010
  url5 = "https://thecocktaildb.com/api/json/v1/1/lookup.php?i=#{k}"
  cocktails = JSON.parse(open(url5).read)
  unless cocktails['drinks'].nil?
    coc = Cocktail.create(
      name: cocktails['drinks'][0]['strDrink'].downcase!,
      description: cocktails['drinks'][0]['strInstructions'],
      style: cocktails['drinks'][0]['strCategory'].downcase,
      category_id: Category.where(name: cocktails['drinks'][0]['strCategory']).first.id,
      glass_id: Glass.where(name: cocktails['drinks'][0]['strGlass']).first.id,
      alcoholic_id: Alcoholic.where(name: cocktails['drinks'][0]['strAlcoholic']).first.id,
      photo_url: cocktails['drinks'][0]['strDrinkThumb']
    )
    cktls << coc
    puts "create #{cocktails['drinks'][0]['strDrink']}"
    measure = cocktails['drinks'][0]["strMeasure#{j}"]
    ing = cocktails['drinks'][0]["strIngredient#{j}"]
    ingd = Ingredient.where(name: ing.downcase)
    unless j == 15 && ing.nil?
      dose = Dose.new(
        measure: measure,
        cocktail_id: coc.id,
        ingredient_id: ingd[0].id
      )
      dose.save(validate: false)
      puts "Creating Doses of #{ing}..."
      j += 1
    end
  end
  k += 1
end

File.open('db/cocktails.json', 'wb') do |file|
  file.write(cktls.to_json)
end
puts 'Finish!!'
