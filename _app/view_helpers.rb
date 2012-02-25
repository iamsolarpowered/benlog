module ViewHelpers

  def twitter_link
    %{ <a href="https://twitter.com/iamsolarpowered" class="twitter-follow-button" data-show-count="false">Follow @iamsolarpowered</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script> }.html_safe
  end

end