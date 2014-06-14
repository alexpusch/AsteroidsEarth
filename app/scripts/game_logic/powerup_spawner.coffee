define ['box2d', 'math_helpers'], (B2D, MathHelpers) ->
  class PowerupSpawner
    constructor: (options = {}) ->
      { @width, @height, @planet } = options

      @config =
        appearance:
          min: 15 * 1000
          max: 25 * 1000

      @powerups = 
        'speed': ->
          window.EntityFactory.createSpeedPowerup()
        'bullet_mass': ->
          window.EntityFactory.createBulletMassPowerup()
        'shockwave': ->
          window.EntityFactory.createShockwavePowerup()
        'shield': ->
          window.EntityFactory.createShieldPowerup()

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
      powerup = @_getRandomPowerup()
      powerup.setPosition new B2D.Vec2 0, 0
      powerup.goToDirection @_getRandomAngle()

    _getRandomAngle: ->
      MathHelpers.random 0, 2 * Math.PI
      
    _getRandomPosition: ->
      o = 10
      x = MathHelpers.random(-@width/2 + o, @width/2 - o)
      y = MathHelpers.random(-@height/2 + o, @height/2 - o)
      new B2D.Vec2 x, y

    _getRandomPowerup: ->
      avilablePowerups = @_getAvilablePowerups()      
      powerupCreationFunction = _.sample  avilablePowerups
      powerupCreationFunction()

    _getAvilablePowerups: ->
      avilablePowerups = _(@powerups).values()
      if @planet.hasShield()
        avilablePowerups = _(avilablePowerups).without @powerups['shield']

      avilablePowerups