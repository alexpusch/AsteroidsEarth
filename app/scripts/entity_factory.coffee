define ['world', 'spaceship', 'bullet'], (World, Spaceship, Bullet)->
  class EntityFactory
    constructor: (@world) ->

    createSpaceship: () ->
      spaceship = new Spaceship
        speed: 2500
        angularSpeed: 5000

      @world.registerEntity spaceship

      spaceship

    createBullet: ->
      bullet = new Bullet

      @world.registerEntity bullet
      bullet