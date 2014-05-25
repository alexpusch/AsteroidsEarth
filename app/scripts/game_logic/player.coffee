define ['box2d'], (B2D)->
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
        @mapping[e.keyCode]?.apply(this, ['on'])
      
      @keyUpCallback = (e) =>
        @mapping[e.keyCode]?.apply(this, ['off'])

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

      false

    handleTouch: (event) ->
      touch = event.touches[0]
      viewPoint = new B2D.Vec2(touch.pageX, touch.pageY)
      worldPoint = @camera.backProject viewPoint

      if @world.hitCheck "astroid", worldPoint
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
      if obj.attachEvent
        obj['e'+type+fn] = fn;
        obj[type+fn] = ->
          obj['e'+type+fn]( window.event )
        obj.attachEvent( 'on'+type, obj[type+fn] );
      else
        obj.addEventListener( type, fn, false );
  
    _removeEvent: ( obj, type, fn ) ->
      if obj.detachEvent
        obj.detachEvent( 'on'+type, obj[type+fn] );
        obj[type+fn] = null;
      else
        obj.removeEventListener( type, fn, false );
    