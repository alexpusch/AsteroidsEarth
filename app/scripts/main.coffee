require ['entity_factory', 'world', 'spaceship', 'player'], (EntityFactory, World, Spaceship, Player) ->
  console.log "main works!!"
  if $('canvas').length > 0
    world = new World
      size:
        width: 200
        height: 200
    
    window.EntityFactory = new EntityFactory world

    world.setupDebugRenderer $('canvas')[0]

    window.spaceship = window.EntityFactory.createSpaceship()

    player = new Player()
    player.control spaceship

    window.setInterval -> 
      world.update()
    , 1000 / 60