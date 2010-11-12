class Feed
  URLS = [
    'http://iamsolarpowered.tumblr.com/rss',
    'http://twitter.com/statuses/user_timeline/17201946.rss'
  ]

  def self.update_all
    Update::COLLECTION.remove({}) #FIXME
    URLS.each do |url|
      FeedNormalizer::FeedNormalizer.parse(open(url).read).entries.each do |entry|
        Update.create!(entry)
      end
    end
  end
end

