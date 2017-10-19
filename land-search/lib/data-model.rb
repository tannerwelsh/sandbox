# Establishes the data models for the app

require_relative './database.rb'

module LandSearch
  class Listing
    include DataMapper::Resource

    property :id, Serial
    property :title, String
    property :description, Text
    property :categories, String
    property :mls, Integer
    property :url, String, required: true
    property :price, Float, required: true
    property :acres, String, required: true
    property :latlong, String
    property :address, String
    property :city, String
    property :county, String
    property :state, String
    property :zip, String

    property :created_at, DateTime
  end

  class Photo
    include DataMapper::Resource

    property :id, Serial
    property :listing_id, Integer, required: true
    property :url, String, required: true
  end
end

# Finalize tables & relationships
DataMapper.finalize
