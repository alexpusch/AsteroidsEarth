require ['world', 'spaceship'], (World, Spaceship) ->
  console.log "main works!!"
  if $('canvas').length > 0
    world = new World
    world.setupDebugRenderer $('canvas')[0]
    window.spaceship = new Spaceship
      speed: 10
      angularSpeed: 10

    world.registerEntity spaceship

    window.setInterval -> 
      world.update()
    , 1000 / 60