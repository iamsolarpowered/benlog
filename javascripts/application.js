(function() {

  angular.module('Benlog', []);

  window.TweetsController = function($scope) {
    $scope.fetch = function(url) {
      return $.getJSON(url, function(response) {
        return $scope.$apply(function() {
          $scope.items = response;
          return $.getScript('//platform.twitter.com/widgets.js');
        });
      });
    };
    return $scope.fetch('https://api.twitter.com/1/statuses/user_timeline.json?count=20&trim_user=true&include_rts=true&screen_name=iamsolarpowered&callback=?');
  };

  window.GoogleReaderController = function($scope) {
    $scope.fetch = function(url) {
      return $.getJSON(url, function(response) {
        return $scope.$apply(function() {
          return $scope.items = response.items;
        });
      });
    };
    return $scope.fetch('http://www.google.com/reader/export/json/user/07268286758726657191/state/com.google/starred?filename=starred-items.json&co=true&at=exKGT3qT-_2cTFjprocdCQ&hl=en&callback=?');
  };

  jQuery(function() {
    return $('a').live('click', function() {
      return $(this).attr('target', '_blank');
    });
  });

}).call(this);
