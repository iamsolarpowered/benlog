jQuery ->
  twitter_url = 'https://api.twitter.com/1/statuses/user_timeline.json?count=100&trim_user=true&include_rts=true&screen_name=iamsolarpowered&callback=?'

  tweets_el = $('.tweets')

  $.getJSON twitter_url, (tweets) ->
    window.console.log tweets
    for tweet in tweets
      t = new Tweet tweet
      t.display()

  class Tweet
    constructor: (@tweet) ->

    text: -> @tweet.text

    formatted_text: -> this.text().autolink().link_twitter_user().link_twitter_hashtag()

    el: -> "<article class='tweet'>#{this.formatted_text()}</article>"

    display: -> tweets_el.append(this.el())

String::autolink = () ->
  this.replace /(https?:\/\/.*?)\W*(\s|$)/gi, "<a href='$1' target='_blank'>$1</a> "

String::link_twitter_user = () ->
  this.replace /(^| )@(\w*)/gi, " <a href='http://twitter.com/$2' target='_blank'>@$2</a>"

String::link_twitter_hashtag = () ->
  this.replace /(^| )#(\w*)/gi, " <a href='http://twitter.com/search/%23$2' target='_blank'>#$2</a>"