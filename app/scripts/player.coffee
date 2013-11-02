define ->
  class Player
    constructor: ->
      @mapping =
        65: @fireLeftThrusters
        87: @fireMainThrusters
        68: @fireRightThrusters

    control: (@spaceship) ->
      $(document).keydown (e) =>
        @mapping[e.keyCode]?.apply(this)

    fireLeftThrusters: ->
      console.log 'fireLeftThrusters'
      @spaceship.fireLeftThrusters()

    fireRightThrusters: ->
      console.log 'fireRightThrusters'
      @spaceship.fireRightThrusters()

    fireMainThrusters: ->
      console.log 'fireMainThrusters'
      @spaceship.fireMainThrusters()