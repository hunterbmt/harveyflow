app.directive 'loginView',[()->
	{
	    restrict: 'A',
	    replace: true,
	    scope: false ,
	    templateUrl: 'partials/user/login.html'
  	}]
app.directive 'signupView',[()->
	{
	    restrict: 'A',
	    replace: false,
	    scope: false,
	    templateUrl: 'partials/user/signup.html'
  	}]
app.directive 'profileView',[()->
	{
	    restrict: 'A',
	    replace: false,
	    scope: false,
	    templateUrl: 'partials/user/profile.html'
  	}]