define ['box2d', 'math_helpers', 'shield_powerup', 'pauseable_timeout'], (B2D, MathHelpers, ShieldPowerup, PauseableTimeout) ->
  class PowerupSpawner
    constructor: (options = {}) ->
      { @width, @height, @planet } = options

      @config =
        appearance:
          min: 15 * 1000
          max: 25 * 1000

      @powerups =
        'speed':
          generator: ->
            window.EntityFactory.createSpeedPowerup()
          frequency: 0.2 * 0.4
        'bullet_mass':
          generator: ->
            window.EntityFactory.createBulletMassPowerup()
          frequency: 0.2 * 0.4
        'shockwave':
          generator: ->
            window.EntityFactory.createShockwavePowerup()
          frequency: 0.2 * 0.2
        'shield':
          generator: ->
            window.EntityFactory.createShieldPowerup()
          frequency: 0.8

    startSpwaning: ->
      @_spawnNext()

    pause: ->
      @timeoutHandler.pause()

    resume: ->
      @timeoutHandler.resume()

    destroy: ->
      @timeoutHandler.clear()

    _spawnNext: ->
      nextSpawnTimeout = _.random @config.appearance.min, @config.appearance.max

      @timeoutHandler = PauseableTimeout.setTimeout =>
        @_spawnPowerup()
        @_spawnNext()
      , nextSpawnTimeout

    _spawnPowerup: ->
      powerup = @_getRandomPowerup()

      if powerup instanceof ShieldPowerup
        @lastShieldSpawned = powerup
        @lastShieldSpawned.events.on "destroy", =>
          delete @lastShieldSpawned

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
      powerupCreationFunction = @_sampleWithFrequencies(avilablePowerups).generator
      powerupCreationFunction()

    _getAvilablePowerups: ->
      avilablePowerups = _(@powerups).clone()
      if @planet.hasShield() or @lastShieldSpawned?
        delete avilablePowerups['shield']

      avilablePowerups

    _sampleWithFrequencies: (objects) ->
      total = _(objects).reduce (sum, obj) ->
        sum + obj.frequency
      , 0

      random = MathHelpers.random 0, total
      accumulation = 0
      for key, value of objects
        accumulation += value.frequency
        if random < accumulation
          return value