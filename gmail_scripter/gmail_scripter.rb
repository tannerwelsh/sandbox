require_relative 'url_extractor'

module GmailScripter

  USERNAME = "tanner@devbootcamp.com"
  PASSWORD = "password"

  class << self
    def output_file
      filename = File.expand_path('../urls.txt', __FILE__)
      File.open(filename, 'w') do |file|
        yield file
      end
    end

    def get_urls(opts = {})
      extractor = GmailScripter::UrlExtractor.new(USERNAME, PASSWORD)

      output_file do |file|
        extractor.all_urls(opts) do |url|
          file << url + "\n"
        end
      end
    end
  end
end

IGNORES = [
  /devbootcamp\.com/,
  /facebook\.com/,
  /twitter\.com/,
  /asana\.com/,
  /trello\.com/,
  /ibeam\.it/
]

GmailScripter.get_urls mailbox: "Resources", ignores: IGNORES
