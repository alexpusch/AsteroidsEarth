define ['box2d', 'math_helpers'], (B2D, MathHelpers) ->
  class PowerupSpawner
    constructor: (options = {}) ->
      { @width, @height } = options

      @config =
        appearance:
          min: 15 * 1000
          max: 25 * 1000

    startSpwaning: ->
      @_spawnNext()

    destroy: ->
      clearTimeout @timeout

    _spawnNext: ->
      nextSpawn = _.random @config.appearance.min, @config.appearance.max
      @timeout = setTimeout =>
        console.log "spawn powerup"
        @_spawnPowerup()
        @_spawnNext()
      , nextSpawn

    _spawnPowerup: ->
      powerup = window.EntityFactory.createSpeedPowerup()
      powerup.setPosition new B2D.Vec2 0, 0
      powerup.goToDirection @_getRandomAngle()

    _getRandomAngle: ->
      MathHelpers.random 0, 2 * Math.PI
      
    _getRandomPosition: ->
      o = 10
      x = MathHelpers.random(-@width/2 + o, @width/2 - o)
      y = MathHelpers.random(-@height/2 + o, @height/2 - o)
      debugger
      new B2D.Vec2 x, y
