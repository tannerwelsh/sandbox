require 'craigslist'

search = Craigslist(
  city: 'newyork',
  category_path: 'mcy',
  query: '-cart -vespa -buggy -scooter -"does not run"',
  search_type: :A,
  min_ask: 499,
  max_ask: 5001,
  has_image: true
)

p search.fetch(10)
