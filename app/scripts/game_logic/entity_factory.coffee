define ['world', 'spaceship', 'bullet', 'astroid', 'planet', 'speed_powerup', 'bullet_mass_powerup', 'shockwave_powerup', 'shield_powerup'], (World, Spaceship, Bullet, Astroid, Planet, SpeedPowerup, BulletMassPowerup, ShockwavePowerup, ShieldPowerup)->
  class EntityFactory
    constructor: (@world, @config) ->

    createSpaceship: () ->
      @_createEntity Spaceship,
        @config.Spaceship

    createBullet: (options = {}) ->
      _.defaults options,
        radius: 0.3
        density: 7

      @_createEntity Bullet, options

    createAstroid: (options = {}) ->
      options.planet = @planet
      @_createEntity Astroid,
        options

    createPlanet: ->
      @planet = @_createEntity Planet,
        radius: 10

      @planet

    createSpeedPowerup: ->
      @_createEntity SpeedPowerup

    createBulletMassPowerup: ->
      @_createEntity BulletMassPowerup

    createShockwavePowerup: ->
      @_createEntity ShockwavePowerup, @world

    createShieldPowerup: ->
      @_createEntity ShieldPowerup, @planet

    _createEntity: (entityType, options = {}) ->
      entity = new entityType options
      @world.registerEntity entity

      if options.position?
        b2dPosition = new B2D.Vec2(options.position.x, options.position.y)
        entity.setPosition b2dPosition

      entity
