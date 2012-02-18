jQuery ->
  twitter_url = 'https://api.twitter.com/1/statuses/user_timeline.json?count=100&trim_user=true&include_rts=true&screen_name=iamsolarpowered&callback=?'

  tweets_el = $('.tweets')
  tweet_template = $('#templates .tweet').first()

  $.getJSON twitter_url, (tweets) ->
    window.console.log tweets
    for tweet in tweets
      t = new Tweet tweet
      t.display()

  class Tweet
    constructor: (@tweet) ->

    text: -> @tweet.text

    formatted_text: -> this.text().autolink().link_twitter_user().link_twitter_hashtag()


    date: -> new Date(@tweet.created_at)

    formatted_date: -> "#{this.date().toLocaleDateString()} #{this.date().toLocaleTimeString()}"

    html: -> 
      _el = tweet_template.clone()
      $('.text', _el).html(this.formatted_text())
      $('.date', _el).text("Posted #{$.timeago(this.date())}").attr('title', this.formatted_date())
      $('.retweets .count', _el).text(@tweet.retweet_count)
      $('.retweets', _el).hide() unless @tweet.retweet_count > 0
      $('.permalink a', _el).attr('href', "http://twitter.com/#{@tweet.user.id}/statuses/#{@tweet.id_str}")
      _el

    display: -> tweets_el.append(this.html())

String::autolink = () ->
  this.replace /(https?:\/\/.*?)\W*(\s|$)/gi, "<a href='$1' target='_blank'>$1</a> "

String::link_twitter_user = () ->
  this.replace /(^| )@(\w*)/gi, " <a href='http://twitter.com/$2' target='_blank'>@$2</a>"

String::link_twitter_hashtag = () ->
  this.replace /(^| )#(\w*)/gi, " <a href='http://twitter.com/search/%23$2' target='_blank'>#$2</a>"