describe 'App Controller', ->

  underTest = null

  scope = null
  rootScope = null

  mockDataRef = jasmine.createSpyObj('usersRef', ['child'])
  mockAngularFire = ->
    console.log('Called')
  mockAngularFireAuth = jasmine.createSpyObj('angularFireAuth', ['initialize', 'login', 'logout'])

  beforeEach ->
    mockFireBase = angular.module('firebase', [])
    module 'myApp'

    inject(($controller, $rootScope) ->
      rootScope = $rootScope
      scope = $rootScope.$new()
      underTest = $controller('AppCtrl', {
        $scope: scope
        $rootScope: $rootScope
        dataRef: mockDataRef
        angularFire: mockAngularFire
        angularFireAuth: mockAngularFireAuth
      })
      null
    )

  it 'It will call auth init upon starting up', ->
    expect(mockAngularFireAuth.initialize).toHaveBeenCalled()

  it 'Login function will delegate to auth login', ->
    scope.login()

    expect(mockAngularFireAuth.login).toHaveBeenCalled()

  it 'Logout function will delegate to auth logout', ->
    scope.logout()

    expect(mockAngularFireAuth.logout).toHaveBeenCalled()

  it 'Should setup angularFire ref for tasks after login', ->

    scope.$emit('angularFireAuth:login', {}, {id: 'TEST-ID'})

    expect(rootScope.tasks).toEqual([])

  it 'Should empty the tasks array after logout', ->
    rootScope.tasks = ['TEST']

    scope.$emit('angularFireAuth:logout')

    expect(rootScope.tasks).toEqual([])

  it 'Should empty the tasks array after logout', ->
    rootScope.tasks = ['TEST']

    scope.$emit('angularFireAuth:error')

    expect(rootScope.tasks).toEqual([])
