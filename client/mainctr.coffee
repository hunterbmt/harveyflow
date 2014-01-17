app.controller 'MainCtr',['$rootScope','$scope','$meteor','$location',($rootScope,$scope,$meteor,$location)->
   Deps.autorun () ->
     if(Meteor.user())
        console.log JSON.stringify(Meteor.user())
        $rootScope.user = Meteor.user()
        $rootScope.apply()
   Meteor.subscribe 'topics',()-> 
        $scope.topics = $meteor('topics').find({})

    $scope.goTo = (path)-> $location.path(path);
    $scope.logout = -> 
        Meteor.logout ()->
            $rootScope.user = Meteor.user()
            $rootScope.apply()
]
