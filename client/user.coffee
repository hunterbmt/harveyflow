app.controller 'UserCtrl',['$scope','$location','$meteor',($scope,$location,$meteor)->
   
    $scope.createUser = (user) ->
        Accounts.createUser user,(error)->
            if(error)
                showErrorNotify("Can't create your account",error.reason)
            else
                $location.path("/")
    $scope.loginUser = (user) ->
        Meteor.loginWithPassword user.username,user.password,(error)->
            if(error)
                 showErrorNotify("Can't login",error.reason)
            else
                $location.path("/")

]