define ['box2d', 'dom_events'], (B2D, DOMEvents)->
  class Player
    constructor: (@camera, @world) ->
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
        handler = @mapping[e.keyCode]
        if handler?
          handler.apply(this, ['on'])
          e.preventDefault()
          false

      @keyUpCallback = (e) =>
        handler = @mapping[e.keyCode]
        if handler?
          handler.apply(this, ['off'])
          e.preventDefault()
          false

      @touchstartCallback = (e) =>
        @handleTouch e

      @touchEndCallback = (e) =>
        @handleTouchEnd e

      @_addEvent document,'keydown', @keyDownCallback
      @_addEvent document, 'keyup', @keyUpCallback

      @_addEvent document, "touchstart", @touchstartCallback
      @_addEvent document, "touchmove", @touchstartCallback
      @_addEvent document, "touchend" , @touchEndCallback

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

    handleTouch: (event) ->
      touch = event.touches[0]
      viewPoint = new B2D.Vec2(touch.pageX, touch.pageY)
      worldPoint = @camera.backProject viewPoint

      if @world.hitCheck "asteroid", worldPoint
        @spaceship.fireCannon()
      else
        @spaceship.turnCannonOff()
      @spaceship.setAutoPilotTarget worldPoint

    handleTouchEnd: (event) ->
      @spaceship.stopAutoPilot()
      @spaceship.turnCannonOff()

    stopControling: ->
      @spaceship.turnCannonOff()
      @spaceship.turnLeftThrustersOff()
      @spaceship.turnRightThrustersOff()
      @spaceship.turnMainThrustersOff()
      @spaceship.stopAutoPilot()

      @_removeEvent document, "keydown", @keyDownCallback
      @_removeEvent document, "keyup", @keyUpCallback

      @_removeEvent document, "touchstart", @touchstartCallback
      @_removeEvent document, "touchmove", @touchstartCallback
      @_removeEvent document, "touchend" , @touchEndCallback

    destroy: ->
      @stopControling()

    _addEvent: ( obj, type, fn ) ->
      DOMEvents.bind obj, type, fn

    _removeEvent: ( obj, type, fn ) ->
      DOMEvents.unbind obj, type, fn
