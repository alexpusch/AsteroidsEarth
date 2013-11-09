require ['entity_factory', 'world', 'spaceship', 'player', 'spaceship_renderer', 'world_renderer'], (EntityFactory, World, Spaceship, Player, SpaceshipRenderer, WorldRenderer) ->
  console.log "main works!!"
  if $('#game-container').length > 0
    world = new World
      size:
        width: 200
        height: 200
    
    window.EntityFactory = new EntityFactory world

    # world.setupDebugRenderer $('canvas')[0]

    window.spaceship = window.EntityFactory.createSpaceship()

    player = new Player()
    player.control spaceship

    world_renderer = new WorldRenderer()
    world_renderer.setupRenderer
      container: '#game-container'

    world_renderer.registerRenderer('spaceship', SpaceshipRenderer)

    mainLoop = ->
      world.update()
      world_renderer.render(world)

      requestAnimFrame mainLoop

    requestAnimFrame mainLoop
