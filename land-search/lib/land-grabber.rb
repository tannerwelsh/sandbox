# LandGrabber scrapes listings from a given website, serializing them as a collection of hashes

require 'uri'
require 'open-uri'
require 'json'

require 'nokogiri'

require_relative './env.rb'

module LandSearch
  class LandGrabber
    attr_reader :listings, :listings_url, :parser

    def initialize(listings_url, parser)
      @listings_url = listings_url
      @parser = parser
    end

    def scrape
      doc = Nokogiri::HTML( _source_html )
      @listings = parser.parse(doc)

      self
    end

    def to_json
      JSON.dump( listings )
    end

  private

    def _source_html
      @source_html ||= open( listings_url ).read
    end
  end

  class Parser
    @all_parsers = []

    def self.inherited(subclass)
      @all_parsers << subclass
    end

    def self.parser_for_hostname(hostname)
      @all_parsers.find { |parser| parser.hostname == hostname }
    end

    def self.parse(doc)
      doc.search( listing_selector ).map do |listing|
        Hash[ parse_map.map { |key, func| [ key, func.call(listing) ] } ]
      end
    end

    def self.hostname
      raise NotImplementedError, 'Must define a hostname method'
    end

    def self.listing_selector
      raise NotImplementedError, 'Must define a listing_selector method'
    end

    def self.parse_map
      raise NotImplementedError, 'Must define a parse_map method'
    end
  end

  class NYLandQuestParser < Parser
    def self.hostname
      'nylandquest.com'
    end

    def self.listing_selector
      '#posts .property'
    end

    def self.parse_map
      @parse_map ||= {
        title: ->(listing) { listing.search('h3.entry-title').text },
        description: ->(listing) { listing.search('p').first.text },
        categories: ->(listing) { listing.search('.byline a').map(&:text).join(',') },
        # mls: ,
        url: ->(listing) { listing.search('a').first['href'] },
        price: ->(listing) { listing.search('.listing-price').text.match(/[\d\,\.]+/)[0].sub(',', '').to_f },
        acres: ->(listing) { listing.search('.listing-size').text.match(/\d+/)[0].to_i },
        latlong: ->(listing) { listing['rel'] },
        # address: ,
        city: ->(listing) { listing.search('.listing-town').text.match(/Town: (.+)/)[1] },
        county: ->(listing) { listing.search('.listing-county').text.match(/County: (.+)/)[1].capitalize },
        state: ->(listing) { 'NY' }
        # zip: 
      }
    end
  end
end

if $0 == __FILE__
  # url = ARGV[0]
  # url = "http://nylandquest.com/results/?county=all&lower-price=0&upper-price=100000&lower-size=3&upper-size=all&category%5B%5D=bordering-state-land&category%5B%5D=country-acreage&category%5B%5D=farmland&category%5B%5D=land-and-cabin&category%5B%5D=land-with-mineral-rights&category%5B%5D=recreational-land&category%5B%5D=timberland&submit=Search"

  # url, parser = URI.parse(url), Parser.parser_for_hostname(url.hostname)
  url = File.join( LandSearch::APP_ROOT, 'tmp/nylandquest.html' )
  parser = NYLandQuestParser

  puts LandSearch::LandGrabber.new(url, parser).scrape.to_json
end
