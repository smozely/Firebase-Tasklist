app = angular.module("myApp", ["firebase"])

app.factory('dataRef', ['Firebase', (Firebase) ->
  new Firebase('https://steve-mosley.firebaseIO.com')
])