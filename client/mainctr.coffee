app.controller 'MainCtr',['$rootScope','$scope','$meteor','$location',($rootScope,$scope,$meteor,$location)->
   Session.setDefault("limit", 10)
   Session.setDefault("topic_per_page",10)
   Deps.autorun () ->
        if(Meteor.user())
            $rootScope.user = Meteor.user()
            $rootScope.apply()
        Meteor.subscribe 'topics',Session.get('limit'),()-> 
            $scope.topics = $meteor('topics').find({},{sort:{created_on:-1}})

    $scope.goTo = (path)-> $location.path(path);
    $scope.logout = -> 
        Meteor.logout ()->
            $rootScope.user = Meteor.user()
            $rootScope.apply()
    $scope.loadMore = ->
        limit = Session.get('limit') + Session.get("topic_per_page")
        Session.set('limit',limit)
]
