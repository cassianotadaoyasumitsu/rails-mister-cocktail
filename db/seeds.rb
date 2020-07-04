require 'open-uri'
require 'JSON'
puts 'Cleaning database...'
Dose.destroy_all
Cocktail.destroy_all
Ingredient.destroy_all
puts 'Database cleaned.'
puts 'Creating new ingredients...'
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
json = open(url).read
objs = JSON.parse(json)
objs['drinks'].each do |drink|
  Ingredient.create(name: drink['strIngredient1'])
end
puts "#{Ingredient.all.count} ingredients created."
puts 'Creating 10 cocktails...'
10.times do
  cocktail = Cocktail.new(
    name: Faker::Coffee.blend_name
  )
  cocktail.save
  ingredients = Ingredient.all.sample(3)
  ingredients.each do |ingredient|
    dose = Dose.new(
      description: Faker::Measurement.volume,
      ingredient_id: ingredient.id,
      cocktail_id: cocktail.id
    )
    dose.save
  end
end
puts '10 cocktails created.'
puts 'All done. Have a nice day.'
