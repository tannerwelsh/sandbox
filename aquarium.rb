# Story:
# - I want to simulate an aquarium. 
# - It should be able to hold fishes of many different
#   species and colors.
# - Fish like to swim. They also like to eat. After eating, they poop.
# - The tank will probably get dirty after a while, so I will
#   have to clean it.

class Aquarium
  def initialize
    @tank = []
    clean!
  end

  def add_to_tank(obj)
    @tank << obj
  end

  def contents_of_tank
    @tank
  end

  def dirty?
    Time.now - @last_cleaned > (3 * 24 * 60 * 60)
  end

  def clean!
    @last_cleaned = Time.now
  end

  def excrement
  end
end

class Fish
  def initialize(species, color, calories = 10)
    @species = species
    @color = color
    @calories = calories
  end 

  def species
    @species
  end

  def color
    @color
  end

  def calories 
    @calories
  end

  def swim!
    @calories -= 20
  end

  def eat(food)
    calories = (food.calories < 20) ? 20 : food.calories
    @calories += calories
  end

  def hungry?
    @calories < 0
  end

  def poop!
    yield self if block_given?
  end
end

my_aquarium = Aquarium.new

fishes = [Fish.new('bass', 'brown', my_aquarium), Fish.new('squirrelfish', 'rainbow', my_aquarium)]
fishes.each do |fish|
  my_aquarium.add_to_tank(fish)
end

puts "Fishes:"
p my_aquarium.contents_of_tank

first_fish = my_aquarium.contents_of_tank.last
second_fish = my_aquarium.contents_of_tank.first

puts "First fish info:"
p first_fish.species
p first_fish.color

puts "Calories before swim:"
p first_fish.calories
first_fish.swim!
puts "Calories after swim:"
p first_fish.calories

if first_fish.hungry?
  puts "Calories before eating:"
  p first_fish.calories
  first_fish.eat(second_fish)

  puts "Calories after eating:"
  p first_fish.calories

  first_fish.poop! do |fish|
    my_aquarium.excrement(fish.poop_size)
  end
end

if my_aquarium.dirty?
  puts "It's dirty!"
  my_aquarium.clean!

  puts "Is it dirty now?"
  p my_aquarium.dirty?
end

my_aquarium.dirty? # => should be false