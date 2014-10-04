var app = angular.module("app", [], ['$compileProvider', function($compileProvider) {
  $compileProvider.directive('compile', ['$compile', function($compile) {
    return function(scope, element, attrs) {
      scope.$watch(
        function(scope) {
         return scope.$eval(attrs.compile);
       },
       function(value) {
        element.html(value);
        $compile(element.contents())(scope);
      }
      );
    };
  }]);
}]);
app.filter('capitalize', function() {
  return function(input, all) {
    return (!!input) ? input.replace(/([^\W_]+[^\s-]*) */g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();}) : '';
  }
});
app.controller('tabsController', ['$scope', '$http', '$sce', '$compile', function ($scope, $http, $sce, $compile) {
  $scope.selected = {
    rules: false,
    ranking: false,
    points: false,
    products: false,
    prizes: false,
    trivia: false,
    termsAndConditions: false
  };
  var _unselectAll = function() {
    for (key in $scope.selected) {
      $scope.selected[key] = false;
    }
  }
  var _changeTemplate = function(tmp) {
    $http.get(templates[tmp]).success(function(data) {
      $scope.template = data;
    });
  };
  $scope.change = function(tmp) {
    if ($scope.selected[tmp])
      return;
    $(".content-box-ctn").addClass("tinRightOut");
    _unselectAll();
    $scope.selected[tmp] = true;
    setTimeout(function(){
      _changeTemplate(tmp);
      setTimeout(function(){
        $('.content-box-ctn').removeClass('tinRightOut');
        $(".content-box-ctn").addClass("slideLeftRetourn");
        setTimeout(function(){
          $('.content-box-ctn').removeClass('slideLeftRetourn');
        }, 1000);
      }, 400);
    }, 800);
  };
}]);
app.controller('rankingController', ['$scope', '$http', 'sessionService', function ($scope, $http, session) {
  $("#users-table").css("display", "");
  $("#subsidiaries-table").css("display", "none");
  $scope.showSubsidiaries = function() {
    $http.get('/api/companies/' + session.company.id + '/subsidiaries/ranking?limit=5').success(function (data) {
      $scope.subsidiaries = data;
      $("#users-table").css("display", "none");
      $("#subsidiaries-table").css("display", "");
    });
  };
  $scope.showUsers = function() {
    $http.get('/api/companies/' + session.company.id + '/users/clusters/' + session.cluster + '/ranking?limit=4').success(function (data) {
      $scope.users = data;
      $http.get('/api/users/' + session.current_user.id + '/ranking').success(function (resp) {
        var include = true;
        if (resp.ranking > 4)
          $scope.user = resp;
        $("#users-table").css("display", "");
        $("#subsidiaries-table").css("display", "none");
      });
    });
  };
  $scope.showUsers();
}]);
app.controller('productsController', ['$scope', '$http', 'sessionService', function ($scope, $http, session) {
  var loadPage = function(page) {
    var limit = 10;
    var offset = page * limit;
    $http.get('/api/companies/' + session.company.id + '/products?limit=' + limit + '&offset=' + offset).success(function (data) {
      $scope.products = data;
    });
  }
  $scope.index = 0;
  $scope.nextPage = function() {
    if ($scope.index < 6) {
      $scope.index++;
      loadPage($scope.index);
    }
  };
  $scope.prevPage = function() {
    if ($scope.index > 0) {
      $scope.index--;
      loadPage($scope.index);
    }
  };
  loadPage($scope.index);
}]);
app.controller('triviaController', ['$scope', '$http', 'sessionService', function($scope, $http, session) {
  var loadQuestion = function() {
    $http.get('/api/trivia/users/' + session.current_user.id + '/next-question').success(function (data) {
      $scope.question = data;
    });
  };
  $scope.answer = function(question_id, option_id) {
    var body = {
      question_id: question_id,
      option_id: option_id
    };
    $http.post('api/trivia/users/' + session.current_user.id + '/answers', body).success(function (data) {
      alert(data.result);
      loadQuestion();
    });
  };
  loadQuestion();
}]);

app.controller('prizesController', ['$scope', '$compile', function($scope, $compile) {
  $scope.majorPrizes = function() {

  };
  $scope.minorPrizes = function() {

  };
  $scope.intermediatePrizes = function() {

  };
}]);