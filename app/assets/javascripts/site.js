angular.module("app", [], ['$compileProvider', function($compileProvider) {
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
}])
.controller('tabsController', ['$scope', '$http', '$sce', '$compile', function ($scope, $http, $sce, $compile) {
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
}]).controller('rankingController', ['$scope', '$http', function ($scope, $http) {
  $http.get('/api/companies/1/users/ranking?limit=4').success(function (data) {
    $scope.ranking = data;
    $http.get('/api/users/1/ranking').success(function (resp) {
      var include = true;
      $scope.ranking.forEach(
        function (e) {
          if (e.id == resp.id)
            include = false;
        }
      )
      if (include) $scope.user = resp;
    });
  });
}]).controller('productsController', ['$scope', '$http', function ($scope, $http) {
  $http.get('/api/products').success(function (data) {
    $scope.products = data;
  });
}]);