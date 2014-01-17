Accounts.validateNewUser (user) ->
	unless user.username && user.username.length >= 4
		throw new Meteor.Error 403,"Username must more than 4 chars"
	user.username.indexOf "root" != -1
	
Accounts.onCreateUser (options,user) ->

	if options.profile
		user.profile = options.profile
	else
		user.profile = {}
	user.profile.gravata_url = Gravatar.imageUrl(options.email)
	user.profile.title = "Beginner"
	user


