define ->
  class Player
    constructor: ->
      @mapping =
        65: @setLeftThrusters # A
        37: @setLeftThrusters # arrow left
        87: @setMainThrusters # W
        38: @setMainThrusters # arrow up
        68: @setRightThrusters # D
        39: @setRightThrusters # arrow right
        32: @fireCannon # space

    control: (@spaceship) ->
      @keyDownCallback = (e) =>
        @mapping[e.keyCode]?.apply(this, ['on'])
      
      @keyUpCallback = (e) =>
        @mapping[e.keyCode]?.apply(this, ['off'])

      $(document).keydown @keyDownCallback

      $(document).keyup @keyUpCallback

    setLeftThrusters: (state) ->
      if state == 'on'
        @spaceship.fireLeftThrusters()
      else 
        @spaceship.turnLeftThrustersOff()

    setRightThrusters: (state) ->
      if state == 'on'
        @spaceship.fireRightThrusters()
      else 
        @spaceship.turnRightThrustersOff()

    setMainThrusters: (state) ->
      if state == 'on'
        @spaceship.fireMainThrusters()
      else 
        @spaceship.turnMainThrustersOff()

    fireCannon: (state) ->
      if state == 'on'
        @spaceship.fireCannon()
      else 
        @spaceship.turnCannonOff()

      false

    destroy: ->
      $(document).off "keydown", @keyDownCallback
      $(document).off "keyup", @keyUp4Callback