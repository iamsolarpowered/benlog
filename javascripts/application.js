(function() {
  jQuery(function() {
    var Tweet, about, offset, tweet_template, tweets_el, twitter_url;
    about = $('.about').first();
    offset = about.offset();
    about.css('position', 'fixed');
    about.css('top', offset.top);
    about.css('left', offset.left);
    twitter_url = 'https://api.twitter.com/1/statuses/user_timeline.json?count=100&trim_user=true&include_rts=true&screen_name=iamsolarpowered&callback=?';
    tweets_el = $('.tweets');
    tweet_template = $('#templates .tweet').first();
    $.getJSON(twitter_url, function(tweets) {
      var t, tweet, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = tweets.length; _i < _len; _i++) {
        tweet = tweets[_i];
        t = new Tweet(tweet);
        _results.push(t.display());
      }
      return _results;
    });
    return Tweet = (function() {
      function Tweet(tweet) {
        this.tweet = tweet;
      }
      Tweet.prototype.text = function() {
        return this.tweet.text;
      };
      Tweet.prototype.formatted_text = function() {
        return this.text().autolink().link_twitter_user().link_twitter_hashtag();
      };
      Tweet.prototype.date = function() {
        return new Date(this.tweet.created_at);
      };
      Tweet.prototype.formatted_date = function() {
        return "" + (this.date().toLocaleDateString()) + " " + (this.date().toLocaleTimeString());
      };
      Tweet.prototype.html = function() {
        var _el;
        _el = tweet_template.clone();
        $('.text', _el).html(this.formatted_text());
        $('.date', _el).text("Posted " + ($.timeago(this.date()))).attr('title', this.formatted_date());
        $('.retweets .count', _el).text(this.tweet.retweet_count);
        if (!(this.tweet.retweet_count > 0)) {
          $('.retweets', _el).hide();
        }
        $('.permalink a', _el).attr('href', "http://twitter.com/" + this.tweet.user.id + "/statuses/" + this.tweet.id_str);
        return _el;
      };
      Tweet.prototype.display = function() {
        return tweets_el.append(this.html());
      };
      return Tweet;
    })();
  });
  String.prototype.autolink = function() {
    return this.replace(/(https?:\/\/.*?)\W*(\s|$)/gi, "<a href='$1' target='_blank'>$1</a> ");
  };
  String.prototype.link_twitter_user = function() {
    return this.replace(/(^| )@(\w*)/gi, " <a href='http://twitter.com/$2' target='_blank'>@$2</a>");
  };
  String.prototype.link_twitter_hashtag = function() {
    return this.replace(/(^| )#(\w*)/gi, " <a href='http://twitter.com/search/%23$2' target='_blank'>#$2</a>");
  };
}).call(this);
