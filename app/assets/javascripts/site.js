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

app.directive('ngIf', function() {
  return {
    link: function(scope, element, attrs) {
      if(scope.$eval(attrs.ngIf)) {
        // remove '<div ng-if...></div>'
        element.replaceWith(element.children())
      } else {
        element.replaceWith(' ')
      }
    }
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
  $scope.change = function(tmp, outAnimation, inAnimation) {
    if ($scope.selected[tmp])
      return;
    $(".content-box").addClass(outAnimation);
    _unselectAll();
    $scope.selected[tmp] = true;
    setTimeout(function(){
      $('.content-box-ctn').css('display', 'none');
      _changeTemplate(tmp);
      $('.content-box').removeClass(outAnimation);
      $(".content-box").addClass(inAnimation);
      setTimeout(function(){
        $('.content-box-ctn').css('display', 'block');
        $('.content-box-ctn').addClass('puffIn');
        setTimeout(function(){
          $('.content-box').removeClass(inAnimation);
          $('.content-box-ctn').removeClass('puffIn');
        }, 1000);
      }, 400);
    }, 700);
  };
  $scope.init = function() {
    _changeTemplate('rules');
    $scope.selected.rules = true;
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
    $http.get('/api/companies/' + session.company.id + '/users/clusters/' + session.cluster + '/ranking?limit=5').success(function (data) {
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
  $('.product-img-up').addClass('puffIn');
  $('.product-img-down').addClass('puffIn');
  var productImages = [
    {
      left: 'saeco',
      right: 'lumea'
    },
    {
      left: 'visapur',
      right: 'depiladoras'
    },
    {
      left: 'senseo',
      right: 'espumadores'
    },
    {
      left: 'secador',
      right: 'planchitas'
    },
    {
      left: 'multi_styler',
      right: ''
    },
    {
      left: 'batidoras',
      right: 'licuadoras'
    },
    {
      left: 'mixer',
      right: ''
    }
  ];
  var loadPage = function(page) {
    $('.product-img-up').removeClass('puffIn');
    $('.product-img-down').removeClass('puffIn');
    $('.product-img-up').css('display', 'none');
    $('.product-img-down').css('display', 'none');
    var limit = 10;
    var offset = page * limit;
    $http.get('/api/companies/' + session.company.id + '/products?limit=' + limit + '&offset=' + offset).success(function (data) {
      $scope.products = data;
      $('.product-img-up').css('display', 'block');
      $('.product-img-down').css('display', 'block');
      $('.product-img-up').addClass('puffIn');
      $('.product-img-down').addClass('puffIn');
      $scope.imgRight = images[productImages[page].left];
      $scope.imgLeft = images[productImages[page].right];
      if (!images[productImages[page].right])
        $('.product-img-down').css('display', 'none');
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

app.controller('prizesController', ['$scope', function($scope) {
  $scope.selectedPrizes = {
    major: true,
    intermediate: false,
    minor: false
  };
  var ctns = { major: $('.major-prize'), intermediate: $('.intermediate-prize'), minor: $('.minor-prize') };
  var _hideAll = function() {
    jQuery.each(ctns, function(i, val) {
      val.addClass("invisible");
    });
    for (key in $scope.selectedPrizes) {
      $scope.selectedPrizes[key] = false;
    }
  }
  $scope.majorPrizes = function() {
    if ($scope.selectedPrizes.major)
      return;
    _hideAll();
    $scope.selectedPrizes.major = true;
    ctns.major.removeClass('invisible');
  };
  $scope.intermediatePrizes = function() {
    if ($scope.selectedPrizes.intermediate)
      return;
    _hideAll();
    $scope.selectedPrizes.intermediate = true;
    ctns.intermediate.removeClass('invisible');
  };
  $scope.minorPrizes = function() {
    if ($scope.selectedPrizes.minor)
      return;
    _hideAll();
    $scope.selectedPrizes.minor = true;
    ctns.minor.removeClass('invisible');
  };
}]);

app.controller('categoriesController', ['$scope', '$http', function($scope, $http) {
  $http.get('/api/categories').success(function (data) {
    var extra = data.length % 4;
    $scope.categories = data.slice(0, data.length - extra);
    $scope.categoriesShort = data.slice(data.length - extra);
    $scope.imgs = images;
  });
}]);

app.controller('groupsController', ['$scope', '$http', function ($scope, $http) {
  var loadCluster = function(cluster) {
    $http.get('/api/clusters/' + cluster + '/subsidiaries').success(function (data) {
      $scope.subsidiaries = data;
    });
  }
  var clusters = ['A', 'B', 'C', 'D', 'E'];
  var index = 0;
  $scope.cluster = clusters[index];
  $scope.nextPage = function() {
    if (index < 4) {
      index++;
      loadCluster(clusters[index]);
      $scope.cluster = clusters[index];
    }
  };
  $scope.prevPage = function() {
    if (index > 0) {
      index--;
      loadCluster(clusters[index]);
      $scope.cluster = clusters[index];
    }
  };
  loadCluster($scope.cluster);
}]);