# frozen_string_literal: true
require 'pry'
require 'json'
require 'open-uri'

#s# Storing api's urls
#surl1 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'
#surl2 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list'
#s# url3 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
#surl4 = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?a=list'
#s
#s# Parsing apis urls
#scategories = JSON.parse(open(url1).read)
#sglasses = JSON.parse(open(url2).read)
#salcoholics = JSON.parse(open(url4).read)
#s
#s# Saving data in json files
#sFile.open('db/categories.json', 'wb') do |file|
#s  file.write(categories)
#s  puts 'saving data...'
#send
#s
#sFile.open('db/glasses.json', 'wb') do |file|
#s  file.write(glasses)
#s  puts 'saving data...'
#send
#s
#sFile.open('db/alcoholics.json', 'wb') do |file|
#s  file.write(alcoholics)
#s  puts 'saving data...'
#send
#s
#sputs 'Creating Categories...'
#scat = []
#scategories['drinks'].each do |category|
#s  cat << category
#send
#s
#s# Creating category object
#scat.each do |i|
#s  Category.create(name: i['strCategory'])
#send
#s
#sputs 'Creating Glasses...'
#sgla = []
#sglasses['drinks'].each do |glass|
#s  gla << glass
#send
#s# Creating glass object
#sgla.each do |i|
#s  Glass.create(name: i['strGlass'])
#send
#s
#sputs 'Creating Alcoholics...'
#salc = []
#salcoholics['drinks'].each do |alcoholic|
#s  alc << alcoholic
#send
#s
#s# Creating alcoholic object
#s
#salc.each do |i|
#s  Alcoholic.create(name: i['strAlcoholic'])
#send
#s
#sputs 'Creating Ingredients...'
#singredients = {}
#si = 1
#suntil i == 600
#s  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=#{i}"
#s  ingredients = JSON.parse(open(url).read)
#s  unless ingredients['ingredients'].nil?
#s    Ingredient.create(
#s      name: ingredients['ingredients'][0]['strIngredient'],
#s      description: ingredients['ingredients'][0]['strDescription'],
#s      sort: ingredients['ingredients'][0]['strType'],
#s      alcohol: ingredients['ingredients'][0]['strAlcohol'],
#s      perc: ingredients['ingredients'][0]['strABV'],
#s      photo_url: "https://www.thecocktaildb.com/images/ingredients/#{ingredients['ingredients'][0]['strIngredient']}.png"
#s    )
#s    puts "create #{ingredients['ingredients'][0]['strIngredient']}"
#s  end
#s  i += 1
#send
#s
#sFile.open('db/ingredients.json', 'wb') do |file|
#s  file.write(ingredients)
#send

puts 'Creating Cocktails...'

cocktails = {}
i = 11_000
until i == 11_001
  url1 = "https://thecocktaildb.com/api/json/v1/1/lookup.php?i=#{i}"
  cocktails = JSON.parse(open(url1).read)
  unless cocktails['drinks'].nil?
    coc = Cocktail.new(
      name: cocktails['drinks'][0]['strDrink'],
      description: cocktails['drinks'][0]['strInstructions'],
      style: cocktails['drinks'][0]['strCategory'],
      category_id: Category.where(name: cocktails['drinks'][0]['strCategory']).first.id,
      glass_id: Glass.where(name: cocktails['drinks'][0]['strGlass']).first.id,
      alcoholic_id: Alcoholic.where(name: cocktails['drinks'][0]['strAlcoholic']).first.id,
      photo_url: cocktails['drinks'][0]['strDrinkThumb']
    )
    coc.save(validate: false)
    puts "create #{cocktails['drinks'][0]['strDrink']}"
  end
    puts 'Creating Doses for this cocktail...'
    j = 1
  unless j >= 15
    unless cocktails['drinks'].nil?
      ing = cocktails['drinks'][0]["strIngredient#{j}"]
      p ing
      im = cocktails['drinks'][0]["strMeasure#{j}"]
      dose = Dose.new(
        measure: im,
        cocktail_id:  coc.id,
        ingredient_id: Ingredient.where('name' => ing).first.id
        )
      dose.save(validate: false)
      j += 1
    end
  end
  i += 1
end

File.open('db/cocktails.json', 'wb') do |file|
  file.write(cocktails)
end
puts 'Finish!!'
