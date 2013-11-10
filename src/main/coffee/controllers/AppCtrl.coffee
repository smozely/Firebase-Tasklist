app.controller('AppCtrl', ['$scope', '$rootScope', 'dataRef', 'angularFire', 'angularFireAuth', ($scope, $rootScope, dataRef, angularFire, angularFireAuth) ->

    # Setup app-wide data
    $rootScope.tasks = []

    # Setup Authentication
    angularFireAuth.initialize(dataRef, {scope: $rootScope, name: "user"})

    $scope.$on("angularFireAuth:login", (evt, user) ->
        tasksRef = dataRef.child('users/' + user.id + "/tasks")
        angularFire(tasksRef, $scope, 'tasks')
    )

    $scope.$on("angularFireAuth:logout", (evt) ->
        $rootScope.tasks = []
    )

    $scope.$on("angularFireAuth:error", (evt, err) ->
        $rootScope.tasks = []
    )

    $scope.login = ->
        angularFireAuth.login("persona")

    $scope.logout = ->
        angularFireAuth.logout()
])