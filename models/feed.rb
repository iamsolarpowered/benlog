require 'open-uri'

class Feed
  URLS = [
    'http://iamsolarpowered.tumblr.com/rss',
    'http://twitter.com/statuses/user_timeline/17201946.rss',
    #'http://www.google.com/reader/public/atom/user%2F07480874648171982816%2Fstate%2Fcom.google%2Fbroadcast'
  ]

  def self.update_all
    URLS.each do |url|
      FeedNormalizer::FeedNormalizer.parse(open(url).read).entries.each do |entry|
        Update.create_from_feed_normalizer_entry(entry)
      end
    end
  end
end

