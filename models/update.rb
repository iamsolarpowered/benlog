require 'rdiscount'

class Update

  include DataMapper::Resource
  property :id          , Serial
  property :content     , String  , :required => true
  property :url         , String  , :required => true, :unique_index => true
  property :published_at, Time
  property :created_at  , DateTime, :required => true
  property :updated_at  , DateTime, :required => true

  before :save, :format_content

  def self.create_from_feed_normalizer_entry(entry)
    return if first(:url => entry.url)
    content = entry.content.blank? ? entry.description : entry.content
    create :content => content, :url => entry.url, :published_at => entry.date_published
  end

  def self.latest
    start_time = Time.now
    Feed.update_all
    all :created_at.gte => start_time, :order => [:published_at]
  end

  def via
    @via ||= case
    when url.match(/twitter.com/)
      'Twitter'
    when url.match(/tumblr.com/)
      'Tumblr'
    when url.match(/feedproxy.google.com/)
      'Google Reader'
    end
  end

  def feed_url
    @feed_url ||= case via
    when 'Twitter'
      'http://twitter.com/iamsolarpowered'
    when 'Tumblr'
      'http://iamsolarpowered.tumblr.com'
    when 'Google Reader'
      'http://www.google.com/reader/shared/07480874648171982816'
    end
  end

  private

  def format_content
    if via == "Twitter"
      link_to_mentions
      link_to_hashtags
      be_humble
    end
    self.content = RDiscount.new(self.content, :autolink).to_html
  end

  def link_to_mentions
    self.content.gsub! /(\W?)@(\w*)/ do
      "#{$1}<a class=\"mention\" href=\"http://twitter.com/#{$2}\">@#{$2}</a>"
    end
  end

  def link_to_hashtags
    self.content.gsub! /(\W?)#(\w*)/ do
      "#{$1}<a class=\"hashtag\" href=\"http://twitter.com/#search?q=%23#{$2}\">##{$2}</a>"
    end
  end

  # Remove my name from tweets
  def be_humble
    self.content.gsub!(/^iamsolarpowered: /, '')
  end

end

