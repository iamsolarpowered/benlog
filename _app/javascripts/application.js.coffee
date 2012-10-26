angular.module 'Benlog', []

window.TweetsController = ($scope) ->

  $scope.fetch = (url) ->
    $.getJSON url, (response) ->
      $scope.$apply -> 
        $scope.items = response
        $.getScript '//platform.twitter.com/widgets.js'

  $scope.fetch 'https://api.twitter.com/1/statuses/user_timeline.json?count=20&trim_user=true&include_rts=true&screen_name=iamsolarpowered&callback=?'


window.GoogleReaderController = ($scope) ->

  $scope.fetch = (url) ->
    $.getJSON url, (response) ->
      $scope.$apply -> 
        $scope.items = response.items

  $scope.fetch 'http://www.google.com/reader/export/json/user/07268286758726657191/state/com.google/starred?filename=starred-items.json&co=true&at=exKGT3qT-_2cTFjprocdCQ&hl=en&callback=?'

jQuery ->
  $('a').live 'click', ->
    $(this).attr('target', '_blank')