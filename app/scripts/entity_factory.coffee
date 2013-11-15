define ['world', 'spaceship', 'bullet'], (World, Spaceship, Bullet)->
  class EntityFactory
    constructor: (@world) ->

    createSpaceship: () ->
      spaceship = new Spaceship
        speed: 40000
        angularSpeed: 500000
        width: 20
        length: 30

      @world.registerEntity spaceship

      spaceship

    createBullet: ->
      bullet = new Bullet

      @world.registerEntity bullet
      bullet