ChatMsg = new Meteor.Collection('chatmsgs')
Meteor.publish 'chatmsgs', () ->
	today = new Date()
	ChatMsg.find {
		create_on:{
			"$gte": new Date(today.getFullYear(),today.getMonth(),today.getDate()),
			"$lt": new Date(today.getFullYear(),today.getMonth(),today.getDate()+1)
		}
	}
Meteor.methods {
	chat: (msg) ->
		check msg,String
		if Meteor.user()
			ChatMsg.insert {
				msg:msg,
				user:{
					name:Meteor.user().username
					id:Meteor.userId()
				},
				create_on: new Date()
			}
		else
			new Meteor.Error(403, "You have to login to chat")
}