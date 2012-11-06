angular.module 'Benlog', []

window.TweetsController = ($scope, $http) ->

  $scope.fetch = (url) ->
    $http.jsonp(url).success (response) ->
      $scope.items = response
      $scope.format()

  $scope.format = ->
    $.getScript '//platform.twitter.com/widgets.js'

  $scope.fetch 'https://api.twitter.com/1/statuses/user_timeline.json?count=20&trim_user=true&include_rts=true&screen_name=iamsolarpowered&callback=JSON_CALLBACK'


window.GoogleReaderController = ($scope, $http) ->

  $scope.fetch = (url) ->
    $http.jsonp(url).success (response) ->
      $scope.items = response.items

  $scope.fetch 'http://www.google.com/reader/public/javascript/user/07268286758726657191/state/com.google/starred?callback=JSON_CALLBACK'

jQuery ->
  $('a').live 'click', ->
    $(this).attr('target', '_blank')