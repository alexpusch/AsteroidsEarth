define ->
  class Player
    constructor: ->
      @mapping =
        65: @setLeftThrusters # A
        87: @setMainThrusters # W
        68: @setRightThrusters # D
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

    destroy: ->
      $(document).off "keydown", @keyDownCallback
      $(document).off "keyup", @keyUpCallback