define ['world', 'spaceship'], (World, Spaceship)->
  class EntityFactory
    constructor: (@world) ->

    createSpaceship: ()->
      spaceship = new Spaceship
        speed: 2500
        angularSpeed: 5000

      @world.registerEntity spaceship

      spaceship