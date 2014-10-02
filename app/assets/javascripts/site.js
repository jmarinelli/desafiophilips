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
  $scope.rules = function() {
    _changeTemplate("rules");
    _unselectAll();
    $scope.selected.rules = true;
  }
  $scope.ranking = function() {
    _changeTemplate("ranking");
    _unselectAll();
    $scope.selected.ranking = true;
  }
  $scope.points = function() {
    _changeTemplate("points");
    _unselectAll();
    $scope.selected.points = true;
  }
  $scope.products = function() {
    _changeTemplate("products");
    _unselectAll();
    $scope.selected.products = true;
  }
  $scope.prizes = function() {
    _changeTemplate("prizes");
    _unselectAll();
    $scope.selected.prizes = true;
  }
  $scope.trivia = function() {
    _changeTemplate("trivia");
    _unselectAll();
    $scope.selected.trivia = true;
  }
  $scope.termsAndConditions = function() {
    _changeTemplate("termsAndConditions");
    _unselectAll();
    $scope.selected.termsAndConditions = true;
  }
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
        $scope.users.forEach(
          function (e) {
            if (e.id == resp.id)
              include = false;
          }
          )
        if (include) $scope.user = resp;
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
app.controller('triviaController', ['$scope', '$http', function($scope, $http) {
  $http.get('/api/trivia/questions/1').success(function (data) {
    $scope.question = data;
  });
}]);