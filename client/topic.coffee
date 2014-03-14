app.controller 'TopicCtrl',['$scope','$routeParams','$location','$meteor',($scope,$routeParams, $location,$meteor)->
    #get_current_topic = -> $scope.topic = $meteor('topics').findOne {_id:$routeParams.topic_id}
    
    if $routeParams.topic_id
        #get_current_topic()
        $scope.topic = $meteor('topics').findOne {_id:$routeParams.topic_id}
        #$scope.$watchCollection 'topics', get_current_topic
    
    $scope.addTopic = (topic) ->
        Meteor.call 'create_topic',topic,(error) ->
            if error
                showErrorNotify "Cannot post topic",error.reason
            else
                $location.path("/")
    $scope.addComment = (comment) ->
        if comment
            current_topic = $scope.topic
            Meteor.call 'add_comment',comment,$routeParams.topic_id,(error) ->
                if error
                    showErrorNotify "Cannot post comment",error.reason
                else
                    console.log(current_topic is $scope.topic)
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