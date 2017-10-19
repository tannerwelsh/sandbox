require 'awesome_print'
require 'gmail'

module GmailScripter
  class UrlExtractor
    attr_reader :client

    def initialize(username, password)
      @client = Gmail.connect! username, password
    end

    #
    # Searches through the specified mailbox for messages
    # with a url in their body and passes the urls from to
    # the specified block
    #
    def all_urls(opts, &block)
      mailbox = opts[:mailbox] || 'INBOX'
      ignores = opts[:ignores] || [/facebook\.com/, /twitter\.com/]

      urls = messages_with_url(mailbox).flat_map { |msg| urls_from(msg) }
      urls = urls.uniq

      urls.each do |url|
        block.call(url) unless ignore_url?(url, ignores)
      end
    end

  private

    def messages_with_url(mailbox)
      client.mailbox(mailbox).find(body: 'http')
    end

    def urls_from(message)
      begin
        text = message.html_part.body.to_s
        text.scan(/https?:\/\/[^\s\"\<]+/).uniq
      rescue
        return []
      end
    end

    def ignore_url?(url, ignores)
      ignores.each do |ignore|
        return true if url =~ ignore
      end
      false
    end
  end
end
