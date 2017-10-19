# Creates a new database connection with DataMapper
# returns the connection uri if executed independently

require_relative './env.rb'

require 'data_mapper'

LandSearch::DB_FILE = File.join(LandSearch::APP_ROOT, 'db/land-search.sqlite3')

# If you want the logs displayed you have to do this before the call to setup
DataMapper::Logger.new($stdout, :debug)

# # A Sqlite3 connection to a persistent database
DataMapper.setup(:default, 'sqlite:' + LandSearch::DB_FILE)


if $0 == __FILE__
  puts 'sqlite:' + LandSearch::DB_FILE
end
