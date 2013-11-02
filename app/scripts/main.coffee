require ['world', 'spaceship', 'player'], (World, Spaceship, Player) ->
  console.log "main works!!"
  if $('canvas').length > 0

    world = new World
      size:
        width: 200
        height: 200
    world.setupDebugRenderer $('canvas')[0]
    window.spaceship = new Spaceship
      speed: 2500
      angularSpeed: 5000

    world.registerEntity spaceship

    player = new Player()
    player.control spaceship

    window.setInterval -> 
      world.update()
    , 1000 / 60