describe 'Task Controller', ->

  underTest = null
  scope = null

  beforeEach ->
    mockFireBase = angular.module('firebase', [])
    module 'myApp'

    inject(($controller, $rootScope) ->
      scope = $rootScope.$new()
      underTest = $controller('TaskCtrl', {$scope: scope})
    )

  it 'Scope has onPress', ->
    expect(scope.onPress).toBeDefined()