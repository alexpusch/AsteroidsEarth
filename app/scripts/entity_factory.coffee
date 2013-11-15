define ['world', 'spaceship', 'bullet'], (World, Spaceship, Bullet)->
  class EntityFactory
    constructor: (@world) ->

    createSpaceship: () ->
      spaceship = new Spaceship
        speed: 40
        angularSpeed: 50
        width: 2
        length: 3

      @world.registerEntity spaceship

      spaceship

    createBullet: ->
      bullet = new Bullet
        radius: 0.1

      @world.registerEntity bullet
      bullet