app.controller 'TopicCtrl',['$scope','$routeParams','$location','$meteor',($scope,$routeParams, $location,$meteor)->
    
    if $routeParams.topic_id

        $scope.topic = $meteor('topics').findOne {_id:$routeParams.topic_id}
    
    $scope.addTopic = (topic) ->
        Meteor.call 'create_topic',topic,(error) ->
            if error
                showErrorNotify "Cannot post topic",error.reason
            else
                $location.path("/")
    $scope.addComment = (comment) ->
        if comment
            Meteor.call 'add_comment',comment,$routeParams.topic_id,(error) ->
                if error
                    showErrorNotify "Cannot post comment",error.reason
                else
                    $scope.new_comment = {}
    $scope.replyComment = (scope,path) ->
        if scope.replying
            Meteor.call 'add_reply',scope.newReply,path,scope.topic._id,scope.$index,(error) ->
                if error
                    showErrorNotify "Cannot reply comment",error.reason
                else
                    scope.replying = !scope.replying
                    $scope.reply={}
            
        else 
            scope.replying = true
]