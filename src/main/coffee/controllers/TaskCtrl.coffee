app.controller('TaskCtrl', ['$scope', ($scope) ->

    $scope.$watch('tasks', ->
        $scope.remaining = $scope.tasks.filter((val) ->
            return !val.complete
        ).length
        $scope.count = $scope.tasks.length - $scope.remaining
    , true)

    $scope.onPress = (e) ->
        if (e.which == 13)
            $scope.tasks.push({
                text: $scope.newTask
            })
            $scope.newTask = ''

    $scope.removeTask = (task) ->
        $scope.tasks.splice($scope.tasks.indexOf(task), 1)

    $scope.removeCompletedTasks = ->
        $scope.tasks = $scope.tasks.filter((val) ->
            return !val.complete
        )

    $scope.markAllTasksComplete = ->
        $scope.tasks.forEach((val) ->
            val.complete = true
        )
])