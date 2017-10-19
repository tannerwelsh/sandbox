require 'faker'
require 'json'
require 'pry'

# data format { year: [[author, gender], [author, gender] ...], year: ... }
bestsellers = (1990..2014).map do |year|
  books = Array.new(20) { { name: Faker::Name.name, gender: ['male', 'female'].sample } }

  [year, books]
end

File.write('bestsellers.json', Hash[bestsellers].to_json)
