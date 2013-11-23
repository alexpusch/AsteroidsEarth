define ['world', 'spaceship', 'bullet', 'astroid', 'planet'], (World, Spaceship, Bullet, Astroid, Planet)->
  class EntityFactory
    constructor: (@world) ->

    createSpaceship: () ->
      @_createEntity Spaceship,
        speed: 40
        angularSpeed: 50
        width: 2
        length: 3

    createBullet: ->
      @_createEntity Bullet, 
        radius: 0.2

    createAstroid: (options = {}) ->
      options.planet = @planet
      @_createEntity Astroid,
        options

    createPlanet: ->
      @planet = @_createEntity Planet,
        radius: 10

      @planet

    _createEntity: (entityType, options) ->
      entity = new entityType options
      @world.registerEntity entity

      if options.position?
        b2dPosition = new B2D.Vec2(options.position.x, options.position.y)
        entity.setPosition b2dPosition

      entity
