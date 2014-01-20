Topics = new Meteor.Collection('topics')

Meteor.publish 'topics',(limit) ->
    comments = null;
    if !limit
        limit = 10;
    topics = Topics.find({},{sort:{created_on:-1},limit : limit})
Meteor.methods {
    create_topic: (topic) ->
        if this.userId
            check topic, Match.ObjectIncluding {
                shared_url:Match.Where (url) ->
                    check url,String
                    url.match(/^https?\:\/\/([^\/?#]+)(?:[\/?#]|$)/i);
                ,
                title:String,
                category:String,
                body:String
            }
            topic.shared_url_domain = simple_domain(topic.shared_url)
            topic.created_on = new Date()
            topic.comments = []
            topic.creator = get_creator_information(Meteor.user())
            topic.comments_count = 0
            Topics.insert(topic)
        else
            throw new Meteor.Error(403,"You have to login first")
    add_comment: (comment,topicId) ->
        if this.userId
            check topicId,String
            check comment, Match.ObjectIncluding {
                body:String
            }
            comment.creator = get_creator_information(Meteor.user())
            comment._id = Random.id()
            comment.created_on = new Date()
            comment.replies = []
            Topics.update({_id:topicId},{$push:{comments:comment},$inc:{comments_count:1}})
        else
            throw new Meteor.Error(403,"You have to login first")
    add_reply: (newReply,path,topicId,index) ->
        if this.userId
            check index,Number
            check topicId,String
            check newReply,String
            reply={}
            reply.body = newReply
            reply.creator = get_creator_information(Meteor.user())
            reply._id = Random.id()
            reply.created_on = new Date()
            reply.replies = []
            if !path
               path = "comments.#{index}.replies"
            else
               path = "#{path}.#{index}.replies"
            reply.path = path
            pushQuery = {}
            pushQuery[path] = reply
            Topics.update({_id:topicId},{$push:pushQuery,$inc:{comments_count:1}})
        else
            throw new Meteor.Error(403,"You have to login first")
}
simple_domain = (url)->
    matches = url.match(/^https?\:\/\/([^\/?#]+)(?:[\/?#]|$)/i);
    if(matches)
        matches[1]
    else
        ""
findCommentWithId = (comments,id) ->
    for comment in comments
        if comment._id is id
            comment
get_creator_information = (user) -> { 
    username : user.username
    profile : user.profile
}
            