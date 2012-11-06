(function() {

  angular.module('Benlog', []);

  window.TweetsController = function($scope, $http) {
    $scope.fetch = function(url) {
      return $http.jsonp(url).success(function(response) {
        $scope.items = response;
        return $scope.format();
      });
    };
    $scope.format = function() {
      return $.getScript('//platform.twitter.com/widgets.js');
    };
    return $scope.fetch('https://api.twitter.com/1/statuses/user_timeline.json?count=20&trim_user=true&include_rts=true&screen_name=iamsolarpowered&callback=JSON_CALLBACK');
  };

  window.GoogleReaderController = function($scope, $http) {
    $scope.fetch = function(url) {
      return $http.jsonp(url).success(function(response) {
        return $scope.items = response.items;
      });
    };
    return $scope.fetch('http://www.google.com/reader/public/javascript/user/07268286758726657191/state/com.google/starred?callback=JSON_CALLBACK');
  };

  jQuery(function() {
    return $('a').live('click', function() {
      return $(this).attr('target', '_blank');
    });
  });

}).call(this);
