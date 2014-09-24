angular.module("app", [], ['$compileProvider', function($compileProvider) {
  $compileProvider.directive('compile', function($compile) {
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
  });
}])
.controller('tabsController', ['$scope', '$http', '$sce', '$compile', function ($scope, $http, $sce, $compile) {
  $scope.changeTemplate = function(tmp) {
    $http.get(templates[tmp]).success(function(data) {
      $scope.template = data;
    });
  };

  $scope.ranking = function() {
    $scope.changeTemplate("ranking");
  }
  $scope.points = function() {
    $scope.changeTemplate("points");
  }
  $scope.products = function() {
    $scope.changeTemplate("products");
  }
  $scope.prizes = function() {
    $scope.changeTemplate("prizes");
  }
  $scope.trivia = function() {
    $scope.changeTemplate("trivia");
  }
  $scope.termsAndConditions = function() {
    $scope.changeTemplate("termsAndConditions");
  }
}]).controller('rankingController', ['$scope', '$http', function ($scope, $http) {
  $http.get('/api/companies/1/users/ranking').success(function (data) {
    $scope.users = data;
  });
}]).controller('productsController', ['$scope', '$http', function ($scope, $http) {
  $http.get('/api/products').success(function (data) {
    $scope.products = data;
  });
}]);