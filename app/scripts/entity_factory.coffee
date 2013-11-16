define ['world', 'spaceship', 'bullet', 'astroid'], (World, Spaceship, Bullet, Astroid)->
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

    createAstroid: (planet) ->
      @_createEntity Astroid,
        radius: 4
        planet: planet

    _createEntity: (entityType, options) ->
      entity = new entityType options
      @world.registerEntity entity

      entity
