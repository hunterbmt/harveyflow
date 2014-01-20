window.app = angular.module('meteorapp', ['meteor','ngRoute','angularMoment'])
  .config ['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when('/', {templateUrl: 'partials/topics/view.html', controller:'TopicsCtrl'})
      .when('/user/login', {templateUrl: 'partials/user/login.html', controller:'UserCtrl'})
      .when('/topic/:topic_id', {templateUrl: 'partials/topic/detail.html', controller:'TopicCtrl'})
      .when('/modify/topic/:topic_id', {templateUrl: 'partials/topic/create.html', controller:'TopicCtrl'})
      .when('/create/topic/', {templateUrl: 'partials/topic/create.html', controller:'TopicCtrl'})
      .when('/chatroom', {templateUrl: 'partials/user/chat-room.html', controller:'ChatCtrl'})
      .otherwise({redirectTo: '/'});
  ]
window.app.run ['$rootScope','$location',($rootScope, $location) ->
    $rootScope.$on "$routeChangeStart", (event, next, current) ->
      if $rootScope.user
        if next.templateUrl is "partials/user/login.html"
          $location.path( "/" );
]
               
$.pnotify.defaults.history = false
window.showErrorNotify = (title,msg) ->
	$.pnotify({
        title: title||'Error',
        text: msg || 'Have some error',
        type: "error",
        animation: "fade",
        styling: "bootstrap",
        delay: 4000
    });