require 'rdiscount'

class Update

  COLLECTION = ::Benlog::DB['updates']
  COLLECTION.create_index 'id'

  def self.all
    COLLECTION.find().sort_by {|u| u['published_at'] }.reverse
  end

  def self.create!(entry)
    new(entry).create!
  end

  def create!
    return if COLLECTION.find(:_id => @_id).count() > 0
    COLLECTION.insert({
      :_id => @_id,
      :content => @content,
      :via => via,
      :url => @url,
      :feed_url => feed_url,
      :published_at => @published_at
    })
  end

  def initialize(entry)
    @entry = entry
    @_id = entry.id
    @url = entry.url
    @content = format_content(entry.content)
    @published_at = entry.date_published
  end

  def via
    if @url =~ /twitter.com/
      'Twitter'
    elsif @url =~ /tumblr.com/
      'Tumblr'
    end
  end

  def feed_url
    if via == 'Twitter'
      'http://twitter.com/iamsolarpowered'
    elsif via == 'Tumblr'
      'http://iamsolarpowered.tumblr.com'
    end
  end

  private

  def format_content(content)
    content.gsub!(/^iamsolarpowered: /, '')
    RDiscount.new(content, :autolink).to_html
  end

end

