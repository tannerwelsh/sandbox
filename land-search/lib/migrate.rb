# Migrate all tables

require_relative './data-model.rb'

DataMapper.auto_upgrade!
