define ->
  class Player
    constructor: ->
      @mapping =
        65: @setLeftThrusters # A
        87: @setMainThrusters # W
        68: @setRightThrusters # D

    control: (@spaceship) ->
      $(document).keydown (e) =>
        @mapping[e.keyCode]?.apply(this, ['on'])

      $(document).keyup (e) =>
        @mapping[e.keyCode]?.apply(this, ['off'])

    setLeftThrusters: (state)->
      console.log 'left'
      if state == 'on'
        @spaceship.fireLeftThrusters()
      else 
        @spaceship.turnLeftThrustersOff()

    setRightThrusters: (state)->
      if state == 'on'
        @spaceship.fireRightThrusters()
      else 
        @spaceship.turnRightThrustersOff()

    setMainThrusters: (state)->
      if state == 'on'
        @spaceship.fireMainThrusters()
      else 
        @spaceship.turnMainThrustersOff()