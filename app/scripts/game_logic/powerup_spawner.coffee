define ['box2d', 'math_helpers'], (B2D, MathHelpers) ->
  class PowerupSpawner
    constructor: (options = {}) ->
      { @width, @height } = options

      @config =
        appearance:
          min: 10000
          max: 20000

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
      powerup.setPosition @_getRandomPosition()


    _getRandomPosition: ->
      o = 10
      x = MathHelpers.random(-@width/2 + o, @width/2 - o)
      y = MathHelpers.random(-@height/2 + o, @height/2 - o)
      debugger
      new B2D.Vec2 x, y
